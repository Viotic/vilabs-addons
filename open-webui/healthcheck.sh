#!/bin/bash
# ==============================================================================
# Health check script for Open WebUI
# ==============================================================================

# Check if the service is responding on port 3000
if curl -f -s http://localhost:3000/health >/dev/null 2>&1; then
    exit 0
elif curl -f -s http://localhost:3000/ >/dev/null 2>&1; then
    exit 0
else
    echo "Open WebUI health check failed"
    exit 1
fi
