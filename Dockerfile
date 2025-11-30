FROM tensorflow/tensorflow:2.12.0

WORKDIR /app

RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    python3-opencv \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
COPY model/ /app/model/

ENV PORT=8080

CMD ["python", "app.py"]
