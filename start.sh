#!/bin/bash
set -e
echo "Starting CN31 Solver..."
echo "Python: $(python --version)"
echo "Files present:"
ls -la /app/*.py /app/*.js /app/*.pkl 2>/dev/null || true
exec python necap.py
