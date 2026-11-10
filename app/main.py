from fastapi import FastAPI

app = FastAPI(title="Demo App")


@app.get("/")
def read_root():
    return {"message": "Hello from the DevSecOps demo app"}


@app.get("/health")
def health():
    return {"status": "ok"}
