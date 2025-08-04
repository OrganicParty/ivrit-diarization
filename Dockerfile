FROM pytorch/pytorch:2.2.0-cuda11.8-cudnn8-runtime

# Install system dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg libsndfile1-dev git && \
    apt-get clean

WORKDIR /app
COPY . .

# Pre-install safe versions
RUN pip install --no-cache-dir --upgrade pip setuptools wheel
RUN pip install --no-cache-dir \
    torch==2.2.0 \
    torchaudio==2.2.0 \
    numpy

# Install the rest
RUN pip install --no-cache-dir \
    whisperx==3.1.0 \
    "pyannote.audio>=3.1" \
    fastapi uvicorn[standard]

EXPOSE 8000
CMD ["python", "api.py"]
