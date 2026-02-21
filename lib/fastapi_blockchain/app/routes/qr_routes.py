# app/routes/qr_routes.py
from fastapi import APIRouter
from app.services.blockchain import get_tracking_data

router = APIRouter()

@router.get("/track/{qr_id}")
def track_product(qr_id: str):
    try:
        data = get_tracking_data(qr_id)
        return {"status": "success", "data": data}
    except Exception as e:
        return {"status": "error", "message": str(e)}
