import os

from flask import Flask
from flask import request, jsonify
from src.translator import translate_content
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route("/")
def translator():
    content = request.args.get("content", default = "", type = str)
    print("TRANSLATOR HIT:", content)
    is_english, translated_content = translate_content(content)
    print("TRANSLATION DATA -->", "is_english: ", is_english, " /// translated_content: ", translated_content)
    return jsonify({
        "is_english": is_english,
        "translated_content": translated_content,
    })


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
