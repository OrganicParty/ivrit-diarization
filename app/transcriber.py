from ivrit.transcribe import transcribe as ivrit_transcribe
import whisperx

def transcribe(audio_path: str,
               diarize: bool = False,
               model_name: str = "whisper-large-v3",
               language: str = "he"):
    """Wrapper that adds optional speaker diarization."""
    base = ivrit_transcribe(audio_path,
                            model_name=model_name,
                            language=language,
                            diarize=False)

    if not diarize:
        return base

    # ---- WhisperX diarization ----
    model, metadata = whisperx.load_model("large-v3", device="cuda")
    diarizer = whisperx.DiarizationPipeline(use_auth_token=True,
                                            device="cuda")
    diarization = diarizer(audio_path)
    segments = whisperx.assign_word_speakers(diarization,
                                             base["segments"])
    base["segments"] = segments
    return base
