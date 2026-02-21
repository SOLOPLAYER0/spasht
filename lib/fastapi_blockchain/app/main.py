# app/main.py
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from app.services.blockchain import register_qr, scan_qr, get_qr
from app.services.qr_service import generate_qr
import uuid

app = FastAPI()

# -------------------------------
# Request Models
# -------------------------------
class RegisterQRRequest(BaseModel):
    farmer_name: str
    location: str

class ScanQRRequest(BaseModel):
    qr_hash: str
    location: str
    scanner_name: str

class ViewQRRequest(BaseModel):
    qr_hash: str


# -------------------------------
# Routes
# -------------------------------

# ✅ Register QR
@app.post("/register-qr")
def register_qr_route(data: RegisterQRRequest):
    try:
        qr_id = str(uuid.uuid4())  # Unique QR ID

        result = register_qr(qr_id, data.location, data.farmer_name)
        qr_img = generate_qr(qr_id)

        return {
            "status": "success",
            "qr_id": qr_id,
            "transaction": result["tx_hash"],
            "qr_image_base64": qr_img,
            "registered_at": result["timestamp"],   # this = Harvest Date
            "farmer_name": data.farmer_name,
            "location": data.location,
        }
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


# ✅ Scan QR (handles entry + exit)
@app.post("/scan-qr")
def scan_qr_route(data: ScanQRRequest):
    try:
        result = scan_qr(data.qr_hash, data.location, data.scanner_name)

        return {
            "status": "success",
            "tx_hash": result["tx_hash"],
            "scanner_name": data.scanner_name,
            "location": data.location,
            "entry_time": result.get("entry_time"),
            "exit_time": result.get("exit_time"),
        }
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


# ✅ View QR (returns full journey with entry + exit times)
# ✅ View QR (returns complete on-chain data)
# app/main.py
@app.post("/view-qr")
def view_qr_route(data: ViewQRRequest):
    try:
        result = get_qr(data.qr_hash)

        journey = result["journey"]
        entry_time = result["entry_time"]
        exit_time = result["exit_time"]
        seller = result["seller"]
        scan_count = result["scan_count"]
        farmer = result["farmer"]        

        return {
            "status": "success",
            "farmer": farmer,
            "entry_time": entry_time,
            "exit_time": exit_time,
            "seller": seller,
            "scan_count": scan_count,
            "journey": journey,
        }
    except Exception:
        raise HTTPException(status_code=404, detail="QR not found")

