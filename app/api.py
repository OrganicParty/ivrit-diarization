import tempfile, os
from fastapi import FastAPI, UploadFile, Form
from app.transcriber import transcribe

app = FastAPI()

@app.post("/transcribe")
async def transcribe_endpoint(file: UploadFile,
                              diarize: bool = Form(False)):
    tmp = tempfile.mktemp(suffix=".wav")
    with open(tmp, "wb") as f:
        f.write(await file.read())

    result = transcribe(tmp, diarize=diarize)
    os.remove(tmp)
    return result
                                
