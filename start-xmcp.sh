#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
XMCP_DIR="$SCRIPT_DIR/xmcp"

if [ ! -f "$XMCP_DIR/.venv/bin/activate" ]; then
  echo "Creating virtual environment..."
  python3 -m venv "$XMCP_DIR/.venv"
  source "$XMCP_DIR/.venv/bin/activate"
  pip install -r "$XMCP_DIR/requirements.txt"
else
  source "$XMCP_DIR/.venv/bin/activate"
fi

if ! grep -q 'X_OAUTH_CONSUMER_KEY=.' "$XMCP_DIR/.env" 2>/dev/null; then
  echo "ERROR: X API credentials not set in xmcp/.env"
  echo "Get them from https://developer.x.com/en/portal/dashboard"
  echo "Required: X_OAUTH_CONSUMER_KEY, X_OAUTH_CONSUMER_SECRET, X_BEARER_TOKEN"
  exit 1
fi

echo "Starting X API MCP server on http://127.0.0.1:8000/mcp ..."
cd "$XMCP_DIR"
python server.py
