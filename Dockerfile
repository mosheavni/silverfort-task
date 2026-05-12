FROM python:3.11-slim

WORKDIR /app

COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

RUN mkdir -p /app/certs \
  && adduser --disabled-password --gecos '' appuser \
  && chown -R appuser /app

USER appuser

EXPOSE 8443

CMD ["python", "app.py"]
