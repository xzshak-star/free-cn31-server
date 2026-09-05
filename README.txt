MITZ FREE CN31 — FIXED FOR RAILWAY (2026-09-06)

What was broken:
- Dockerfile used python:3.11-slim-bullseye + package list that fails on current mirrors
  (libasound2, libgl1-mesa-glx, etc. renamed / removed → apt exit 100)
- Chrome + chromedriver install was unnecessary (solver is pure torch + execjs, no Selenium)

What I fixed:
1. Base image → python:3.11-slim-bookworm
2. Only the real system libs needed by opencv-headless + torch
3. Removed all Chrome / Node / xvfb / selenium packages
4. requirements.txt cleaned (dropped selenium)
5. start.sh simplified
6. railway.json forced to DOCKERFILE builder
7. nixpacks.toml stripped of chrome

Deploy on Railway:
1. Push this folder (or zip) to your GitHub repo
2. New Railway project → Deploy from GitHub
3. Settings → Builder = Dockerfile (or leave railway.json)
4. Variables (optional):
   PORT=6000
   NUM_THREADS=5
   TOKEN_SERVER_URL=https://your-token-server.up.railway.app
5. Deploy. Health: GET /health

Local test:
  docker build -t mitz-cn31 .
  docker run -p 6000:6000 mitz-cn31

Endpoints (from necap.py):
  GET  /health
  GET  /api/status
  GET  /api/get-token
  GET  /api/token/bulk?n=5
  POST /start   {"threads": 8}
  POST /stop
