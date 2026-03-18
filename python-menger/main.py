from fastapi import FastAPI, Request
import os
from datetime import datetime

app = FastAPI()

# ===== LOG FUNCTION =====
def write_log(message: str):
    today = datetime.now().strftime("%Y%m%d")
    log_dir = f"/logs/{today}"

    # สร้าง folder ถ้ายังไม่มี
    os.makedirs(log_dir, exist_ok=True)

    log_file = f"{log_dir}/log.txt"

    timestamp = datetime.now().isoformat()

    with open(log_file, "a", encoding="utf-8") as f:
        f.write(f"[{timestamp}] {message}\n")


# ===== MIDDLEWARE LOG ทุก request =====
@app.middleware("http")
async def log_requests(request: Request, call_next):
    client_ip = request.client.host
    method = request.method
    url = request.url.path

    write_log(f"Request from {client_ip} {method} {url}")

    response = await call_next(request)

    write_log(f"Response status {response.status_code}")

    return response


# ===== ROUTE =====
@app.get("/")
def info():
    write_log("GET / called")

    return {
        "python-menger": {
            "package_manager": "pip",
            "dependency_file": "requirements.txt",
            "source_code": "main.py",
            "runtime": "Python interpreter"
        }
    }


# ===== START LOG =====
@app.on_event("startup")
def startup_event():
    write_log("Python FastAPI server started")