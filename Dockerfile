# MITZ CN31 — zero-apt Dockerfile (Railway cache-bust + no package failures)
# Build: docker build -t mitz-cn31 .
FROM python:3.11-slim-bookworm

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PORT=6000 \
    HEADLESS=true \
    NUM_THREADS=5 \
    OPENCV_IO_ENABLE_OPENEXR=0

WORKDIR /app

# No apt-get. opencv-python-headless + torch wheels ship their own libs.
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

COPY necap.py yidun_proxyless.py dun163.js net.pkl start.sh ./
RUN chmod +x start.sh

EXPOSE 6000
CMD ["python", "necap.py"]
