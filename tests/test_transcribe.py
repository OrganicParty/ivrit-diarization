from app.transcriber import transcribe

def test_basic_transcription():
    result = transcribe("tests/sample.wav", diarize=False, model_name="tiny", language="he")
    assert "segments" in result
