import os
from openai import OpenAI
from openai import OpenAIError

# Initialize OpenAI client
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

def translate_content(content: str) -> tuple[bool, str]:
    prompt = f"""
You are a helpful assistant that determines whether a message is in English, another language, or complete gibberish.

Respond with ONLY one of the following formats:

If the message is in English:
ENGLISH|<original message>

If the message is in another language:
TRANSLATED|<translated English message>

If the message is gibberish or nonsense and cannot be understood:
GIBBERISH|<original message>

Do NOT say anything else. Only respond with one of the formats above.

Message: {content}
"""

    try:
        response = client.chat.completions.create(
            model="gpt-4o",  # or use gpt-3.5-turbo if needed
            messages=[{"role": "user", "content": prompt}],
            temperature=0.2,
        )

        reply = response.choices[0].message.content.strip()

        if reply.startswith("ENGLISH|"):
            return True, reply[len("ENGLISH|"):].strip()
        elif reply.startswith("TRANSLATED|"):
            return False, reply[len("TRANSLATED|"):].strip()
        elif reply.startswith("GIBBERISH|"):
            return True, reply[len("GIBBERISH|"):].strip()
        else:
            # Unexpected response fallback
            return True, content

    except OpenAIError as e:
        print("LLM ERROR:", e)
        return True, content  # fallback
