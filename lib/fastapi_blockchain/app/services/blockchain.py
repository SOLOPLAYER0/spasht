from web3 import Web3
import os
import json
import time
from dotenv import load_dotenv
import firebase_admin
from firebase_admin import credentials, firestore

# -----------------------
# Load ENV
# -----------------------
load_dotenv()

quicknode_url = os.getenv("Quicknode_URL")
contract_address = os.getenv("CONTRACT_ADDRESS")
abi_string = os.getenv("CONTRACT_ABI")
firebase_key_path = os.getenv("FIREBASE_KEY_PATH", "firebase_key.json")
FARMER_SHARED_WALLET_ADDRESS = os.getenv("FARMER_SHARED_WALLET_ADDRESS")
FARMER_SHARED_WALLET_PRIVATE_KEY = os.getenv("FARMER_SHARED_WALLET_PRIVATE_KEY")

if not FARMER_SHARED_WALLET_ADDRESS or not FARMER_SHARED_WALLET_PRIVATE_KEY:
    raise ValueError("Missing FARMER_SHARED_WALLET_ADDRESS or FARMER_SHARED_WALLET_PRIVATE_KEY in .env")

SHARED_WALLET = {
    "address": FARMER_SHARED_WALLET_ADDRESS,
    "private_key": FARMER_SHARED_WALLET_PRIVATE_KEY,
}

if not quicknode_url or not contract_address or not abi_string:
    raise ValueError("Missing one or more environment variables (Quicknode_URL, CONTRACT_ADDRESS, CONTRACT_ABI)")

# Parse ABI
try:
    abi = json.loads(abi_string)
except json.JSONDecodeError as e:
    raise ValueError(f"Error parsing CONTRACT_ABI: {e}")

# -----------------------
# Blockchain Setup
# -----------------------
web3 = Web3(Web3.HTTPProvider(quicknode_url))

if not web3.is_connected():
    raise ConnectionError("❌ Failed to connect to Ethereum/Polygon network.")

print("✅ Connected to QuickNode!")
print(f"Current Block Number: {web3.eth.block_number}")

contract = web3.eth.contract(
    address=Web3.to_checksum_address(contract_address),
    abi=abi
)

# -----------------------
# Firebase Setup
# -----------------------
cred = credentials.Certificate(firebase_key_path)
if not firebase_admin._apps:
    firebase_admin.initialize_app(cred)

db = firestore.client()


# -----------------------
# Blockchain Functions
# -----------------------
def register_qr(qr_hash: str, location: str, farmer_name: str):
    """
    Register a QR on-chain using the SHARED_WALLET and store in Firebase
    """
    qr_hash_bytes = Web3.keccak(text=qr_hash)

    nonce = web3.eth.get_transaction_count(SHARED_WALLET["address"])

    txn = contract.functions.registerQR(qr_hash_bytes, location).build_transaction({
        "from": SHARED_WALLET["address"],
        "nonce": nonce,
        "gas": 200000,
        "gasPrice": web3.eth.gas_price
    })

    signed_txn = web3.eth.account.sign_transaction(txn, private_key=SHARED_WALLET["private_key"])
    tx_hash = web3.eth.send_raw_transaction(signed_txn.raw_transaction)
    web3.eth.wait_for_transaction_receipt(tx_hash)

    qr_data = {
        "qr_hash": qr_hash,
        "location": location,
        "farmer_name": farmer_name,              # save who triggered it
        "owner": SHARED_WALLET["address"],       # blockchain wallet
        "tx_hash": tx_hash.hex(),
        "registered_at": int(time.time())
    }
    db.collection("qrcodes").document(qr_hash).set(qr_data)

    return {"tx_hash": tx_hash.hex(), "timestamp": qr_data["registered_at"]}


def scan_qr(qr_hash: str, location: str, scanner_name: str):
    """
    Record a scan on-chain with SHARED_WALLET and update Firebase.
    Handles entry + exit for each seller dynamically.
    """
    qr_hash_bytes = Web3.keccak(text=qr_hash)

    nonce = web3.eth.get_transaction_count(SHARED_WALLET["address"])

    txn = contract.functions.scanQR(qr_hash_bytes, location).build_transaction({
        "from": SHARED_WALLET["address"],
        "nonce": nonce,
        "gas": 200000,
        "gasPrice": web3.eth.gas_price
    })

    signed_txn = web3.eth.account.sign_transaction(txn, private_key=SHARED_WALLET["private_key"])
    tx_hash = web3.eth.send_raw_transaction(signed_txn.raw_transaction)
    web3.eth.wait_for_transaction_receipt(tx_hash)

    scans_ref = db.collection("qrcodes").document(qr_hash).collection("scans")

    # 🔹 Check if this seller already has an active entry without exit
    existing = scans_ref.where("scanned_by", "==", scanner_name).where("exit_time", "==", None).stream()
    active_doc = None
    for doc in existing:
        active_doc = doc
        break

    now = int(time.time())

    if active_doc:
        # Update exit time
        scans_ref.document(active_doc.id).update({
            "exit_time": now,
            "exit_tx_hash": tx_hash.hex()
        })
        return {"tx_hash": tx_hash.hex(), "exit_time": now}

    else:
        # New entry
        scan_data = {
            "location": location,
            "scanned_by": scanner_name,
            "blockchain_wallet": SHARED_WALLET["address"],
            "entry_time": now,
            "exit_time": None,
            "entry_tx_hash": tx_hash.hex()
        }
        scans_ref.add(scan_data)
        return {"tx_hash": tx_hash.hex(), "entry_time": now}


def get_qr(qr_hash):
    qr_hash_bytes = Web3.keccak(text=qr_hash)

    journey, entry, exit, seller, scan_count = contract.functions.getQR(qr_hash_bytes).call()
    qr_obj = contract.functions.qrs(qr_hash_bytes).call()

    farmer = qr_obj[3]   # farmer address

    return {
        "journey": journey,
        "entry_time": entry,
        "exit_time": exit,
        "seller": seller,
        "scan_count": scan_count,
        "farmer": farmer
    }

