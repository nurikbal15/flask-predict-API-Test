# Gunakan Python 3.10 (nggak perlu PPA deadsnakes)
FROM python:3.10-slim

# Biar log langsung tampil
ENV PYTHONUNBUFFERED=1

# (Opsional tapi disarankan) lib dasar yang sering dibutuhkan TensorFlow / image
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libglib2.0-0 libsm6 libxext6 libxrender1 \
    && rm -rf /var/lib/apt/lists/*

# Folder kerja di dalam container
WORKDIR /app

# Copy requirements dulu (biar cache build lebih efektif)
COPY requirements.txt .

# Sama seperti:
#   pip install flask flask-cors
#   pip install tensorflow==2.15.*
#   pip install -r requirements.txt
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir flask flask-cors && \
    pip install --no-cache-dir "tensorflow==2.15.*" && \
    pip install --no-cache-dir -r requirements.txt

# Copy semua file project (app.py, model, dll)
COPY . .

# Cloud Run (atau container lain) akan kasih env PORT sendiri
ENV PORT=8080
EXPOSE 8080

# Sama dengan: python app.py
CMD ["python", "app.py"]
