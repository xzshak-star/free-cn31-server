# Fixed for Railway / Docker — no broken apt packages
FROM python:3.11-slim-bookworm

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PORT=6000
ENV HEADLESS=true
ENV NUM_THREADS=5

# Minimal system deps (opencv + torch CPU only need these)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    ca-certificates \
    libglib2.0-0 \
    libgomp1 \
    libgl1 \
    libsm6 \
    libxext6 \
    libxrender1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY necap.py .
COPY yidun_proxyless.py .
COPY dun163.js .
COPY net.pkl .
COPY start.sh .

RUN chmod +x start.sh

EXPOSE 6000

CMD ["python", "necap.py"]
