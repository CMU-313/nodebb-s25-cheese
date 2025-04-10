from src.translator import translate_content


def test_spanish_translation():
    is_english, translated_content = translate_content("Esta es un mensaje en español")
    assert is_english == False
    assert "This is a message in Spanish" in translated_content

def test_english_message():
    is_english, translated_content = translate_content("This is an English message")
    assert is_english == True
    assert translated_content == "This is an English message"

def test_german_translation():
    is_english, translated_content = translate_content("Dies ist eine Nachricht auf Deutsch")
    assert is_english == False
    assert "This is a message in German" in translated_content

def test_empty_string():
    is_english, translated_content = translate_content("")
    assert is_english == True
    assert translated_content == ""

def test_mixed_language():
    is_english, translated_content = translate_content("Hola! This is a test.")
    # Depending on LLM behavior, it might treat it as English or non-English
    assert translated_content  # just check it's not empty

def test_llm_normal_response():
    is_english, translated_content = translate_content("Esta es un mensaje en español")
    assert is_english == False
    assert translated_content == "This is a message in Spanish"

    is_english, translated_content = translate_content("This is a spanish message!!!")
    assert is_english == True
    assert translated_content == "This is a spanish message!!!"



def test_llm_gibberish_response():
    is_english, translated_content = translate_content("ghdfzijgvjklESg")
    assert is_english == True
    assert translated_content == "ghdfzijgvjklESg"
