// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Spasht {
    struct QR {
        string[] journey;
        uint256 entryTime;
        uint256 exitTime;
        address seller;
        uint256 scanCount;
        address farmer;
        bool exists;
        bool inEntryPhase;  // To track if the product is still in the entry phase
    }

    mapping(bytes32 => QR) public qrs; // QR code ID (hash or URL) => QR data

    event QRRegistered(bytes32 indexed qrHash);
    event QRUpdated(bytes32 indexed qrHash, address indexed seller, string location);
    event QRScanned(bytes32 indexed qrHash, address indexed scanner, uint256 scanTime, string scanType);

    // 🔵 1. Register a new QR (Farmer generates it)
    // 🔵 1. Register a new QR (Farmer generates it)
    function registerQR(bytes32 _qrHash, string memory _initialLocation) public {
        require(!qrs[_qrHash].exists, "QR already exists");

        QR storage newQR = qrs[_qrHash];
        newQR.entryTime = block.timestamp;
        newQR.exitTime = block.timestamp; // For farmer, both are same
        newQR.journey.push(_initialLocation);
        newQR.exists = true;
        newQR.farmer = msg.sender; 
        newQR.inEntryPhase = true;  // Mark as entry phase when it's registered

        emit QRRegistered(_qrHash);
    }


    // 🟠 2. Seller scans the QR (entry or exit)
    function scanQR(bytes32 _qrHash, string memory _location) public {
        require(qrs[_qrHash].exists, "QR not found");
        QR storage qr = qrs[_qrHash];

        // Prevent any scan while QR is in entry phase (seller cannot scan before exiting the previous seller)
        require(!qr.inEntryPhase, "QR is currently in entry phase, please wait for the current seller to exit");

        // Handle Farmer's scan
        if (msg.sender == qr.farmer && qr.scanCount == 0) {
            // ✅ This ensures only the original farmer can perform the farm exit scan
            qr.exitTime = block.timestamp;
            qr.journey.push(_location);
            qr.scanCount = 1;
            emit QRScanned(_qrHash, msg.sender, block.timestamp, "Farmer Exit Scan");
        }
        // Handle Seller's scan
        else if (qr.scanCount == 1) {
            // Seller's first scan (Entry to seller's possession)
            qr.entryTime = block.timestamp; // Mark entry time
            qr.seller = msg.sender;         // Mark the seller
            qr.scanCount = 2;               // Increment scan count for seller entry
            qr.journey.push(_location);     // Log the seller's location
            qr.inEntryPhase = true;         // Mark QR as in entry phase
            emit QRScanned(_qrHash, msg.sender, block.timestamp, "Seller Entry Scan");
        } 
        // Handle subsequent Seller Exit scans
        else if (qr.scanCount > 1) {
            // Entry phase has already passed, and now another seller is scanning
            if (!qr.inEntryPhase) {
                // Seller exit scan
                qr.exitTime = block.timestamp; // Mark exit time
                qr.scanCount++;                // Increment scan count for the next seller
                qr.journey.push(_location);    // Log the exit location
                qr.inEntryPhase = false;       // End entry phase after seller exit
                emit QRScanned(_qrHash, msg.sender, block.timestamp, "Seller Exit Scan");
            }
        } 
        else {
            revert("Invalid state or scan count for the QR.");
        }

        emit QRUpdated(_qrHash, msg.sender, _location); // Update the QR data
    }

    // 🟢 3. Public read-only QR info (for Individuals)
    function getQR(bytes32 _qrHash) public view returns (
        string[] memory journey,
        uint256 entryTime,
        uint256 exitTime,
        address seller,
        uint256 scanCount
    ) {
        require(qrs[_qrHash].exists, "QR not found");
        QR storage qr = qrs[_qrHash];
        return (
            qr.journey,
            qr.entryTime,
            qr.exitTime,
            qr.seller,
            qr.scanCount
        );
    }
}
