FROM python:3.10-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy aplikasi
COPY . .

# Cloud Run akan pakai PORT environment variable
ENV PORT=8080
EXPOSE 8080

# Start Flask app
CMD ["python", "app.py"]
