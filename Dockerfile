FROM pytorch/pytorch:2.2.0-cuda11.8-cudnn8-runtime

RUN apt-get update && apt-get install -y \
    ffmpeg libsndfile1-dev git && \
    apt-get clean

WORKDIR /app
COPY . .

# Upgrade pip & tools
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# Step-by-step installation (isolate errors)
RUN pip install --no-cache-dir torch==2.2.0 torchaudio==2.2.0 numpy
RUN pip install --no-cache-dir whisperx==3.1.0
RUN pip install --no-cache-dir "pyannote.audio>=3.1"
RUN pip install --no-cache-dir fastapi
RUN pip install --no-cache-dir "uvicorn[standard]"

EXPOSE 8000
CMD ["python", "api.py"]
