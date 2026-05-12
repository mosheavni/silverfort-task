import requests
from flask import Flask

app = Flask(__name__)


def get_tel_aviv_temp() -> str:
    try:
        resp = requests.get(
            "https://wttr.in/Tel-Aviv?format=+%C+%t%20feels%20like%20+%f", timeout=5
        )
        resp.raise_for_status()
        temp = resp.text.strip()
        return temp
    except Exception:
        return "N/A"


@app.route("/")
def index():
    temperature = get_tel_aviv_temp()
    return f"<h1>Tel Aviv Weather: {temperature}</h1>"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3000)
