MITZ FREE CN31 — V2 ZERO-APT (2026-09-06)

Previous build failed because Railway was still running the OLD Dockerfile
(with libasound2 / libgl1-mesa-glx / xvfb). That layer was cached.

This version:
- ZERO apt-get lines (nothing can exit 100)
- torch CPU wheels only (smaller, no CUDA)
- opencv-python-headless (no system OpenGL)
- Force DOCKERFILE builder in railway.json

Deploy steps that actually clear the cache:
1. Delete the old Railway service OR click "Clear build cache" / redeploy with empty cache
2. Push this entire folder to the repo (overwrite every file)
3. In Railway → Settings → Build:
   - Builder: Dockerfile
   - Dockerfile path: Dockerfile
4. Redeploy

Or just create a brand-new Railway project from the same repo.

Endpoints stay the same:
  GET  /health
  GET  /api/status
  GET  /api/get-token
  GET  /api/token/bulk?n=5
  POST /start  {"threads":8}
  POST /stop
