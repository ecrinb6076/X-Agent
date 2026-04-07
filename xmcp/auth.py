"""One-time OAuth1 authorization. Run interactively, then the server reuses cached tokens."""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from server import load_env, setup_logging, run_oauth1_flow, _save_tokens

load_env()
setup_logging()

print("Starting OAuth1 authorization flow...")
print("A browser window will open. Authorize the app, then enter the PIN here.\n")

access_token, access_secret = run_oauth1_flow()
_save_tokens(access_token, access_secret)

print(f"\nTokens saved. The MCP server will reuse them automatically.")
print("Start the server with: ./start-xmcp.sh")
