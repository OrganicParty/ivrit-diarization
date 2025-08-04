# Use ivrit base image
FROM ivritai/whisper-runpod-serverless:2025.0710

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
