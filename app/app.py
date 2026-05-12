import time

import requests
from flask import Flask

app = Flask(__name__)

_weather_cache: dict = {"temp": None, "ts": 0}
CACHE_TTL = 60


def get_tel_aviv_temp() -> str:
    now = time.time()
    if _weather_cache["temp"] and (now - _weather_cache["ts"]) < CACHE_TTL:
        return _weather_cache["temp"]
    try:
        resp = requests.get(
            "https://wttr.in/Tel-Aviv?format=+%C+%t%20feels%20like%20+%f", timeout=5
        )
        resp.raise_for_status()
        temp = resp.text.strip()
        _weather_cache["temp"] = temp
        _weather_cache["ts"] = now
        return temp
    except Exception:
        return _weather_cache["temp"] or "N/A"


@app.route("/")
def index():
    temperature = get_tel_aviv_temp()
    return f"<h1>Tel Aviv Weather: {temperature}</h1>"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3000)
