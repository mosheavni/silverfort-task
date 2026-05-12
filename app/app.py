import os
import socket
import time

import requests
from flask import Flask, render_template, request

app = Flask(__name__)

CERT_FILE = os.environ.get("CERT_FILE", "/app/certs/cert.pem")
KEY_FILE = os.environ.get("KEY_FILE", "/app/certs/key.pem")
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
    forwarded_for = request.headers.get("X-Forwarded-For", "")
    client_ip = (
        forwarded_for.split(",")[0].strip() if forwarded_for else request.remote_addr
    )
    container_name = socket.gethostname()
    temperature = get_tel_aviv_temp()
    return render_template(
        "index.html",
        client_ip=client_ip,
        container_name=container_name,
        temperature=temperature,
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8443, ssl_context=(CERT_FILE, KEY_FILE))
