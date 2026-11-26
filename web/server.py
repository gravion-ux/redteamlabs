#!/usr/bin/env python3
"""redteamlabs web dashboard — stdlib only, no dependencies.

Serves a status page and a JSON health endpoint for the three labs.
Run: python3 web/server.py  (listens on 127.0.0.1:8090)
"""
import json
import os
import urllib.request
from http.server import BaseHTTPRequestHandler, HTTPServer

PORTS = [int(p) for p in os.environ.get("REDTEAMLABS_PORTS", "8080 8081 8082").split()]
HOST = os.environ.get("REDTEAMLABS_HOST", "127.0.0.1")


def probe(port: int) -> int:
    try:
        with urllib.request.urlopen(f"http://{HOST}:{port}/", timeout=3) as resp:
            return resp.status
    except Exception:
        return 0


def health() -> dict:
    labs = []
    for i, port in enumerate(PORTS, start=1):
        code = probe(port)
        labs.append({"lab": i, "port": port, "http": code, "up": code == 200})
    return {"labs": labs, "all_up": all(l["up"] for l in labs)}


PAGE = """<!doctype html>
<html><head><title>RedTeam Labs</title></head>
<body>
<h1>RedTeam Labs</h1>
<p>Three local WordPress labs. Status refreshes from <code>/api/health</code>.</p>
<pre id="out">loading...</pre>
<script>
fetch('/api/health').then(r => r.json()).then(d => {
  document.getElementById('out').textContent = JSON.stringify(d, null, 2);
});
</script>
</body></html>
"""


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/api/health":
            body = json.dumps(health()).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
        else:
            body = PAGE.encode()
            self.send_response(200)
            self.send_header("Content-Type", "text/html")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, *args):
        pass


def main():
    port = int(os.environ.get("REDTEAMLABS_WEB_PORT", "8090"))
    HTTPServer(("127.0.0.1", port), Handler).serve_forever()


if __name__ == "__main__":
    main()
