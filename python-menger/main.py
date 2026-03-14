from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def info():
    return {
        "python-menger": {
            "package_manager": "pip",
            "dependency_file": "requirements.txt",
            "source_code": "main.py",
            "runtime": "Python interpreter"
        }
    }