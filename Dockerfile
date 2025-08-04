FROM pytorch/pytorch:2.2.0-cuda11.8-cudnn8-runtime

# Install basic tools
RUN apt-get update && apt-get install -y \
    ffmpeg git libsndfile1-dev && \
    apt-get clean

# Set workdir
WORKDIR /app

# Copy requirements (optional)
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir \
    whisperx==3.1.0 \
    "pyannote.audio>=3.1" \
    fastapi uvicorn[standard]

# Expose port for API
EXPOSE 8000

# Default entrypoint
CMD ["python", "api.py"]
