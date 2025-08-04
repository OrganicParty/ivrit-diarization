# Use ivrit base image
FROM python:3.10-slim

# Install diarization dependencies
RUN pip install --no-cache-dir \
    whisperx==3.1.0 \
    "pyannote.audio>=3.1" \
    fastapi uvicorn[standard]

# Copy our project files
COPY . /workspace/ivrit-diarization
ENV PYTHONPATH=/workspace/ivrit-diarization

WORKDIR /workspace/ivrit-diarization
EXPOSE 8000
ENTRYPOINT ["python", "-m", "app.api"]
