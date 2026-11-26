"""Tests for web/server.py health logic (no network beyond loopback)."""
import os
import sys
import threading
from http.server import HTTPServer, BaseHTTPRequestHandler

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "web"))
import server  # noqa: E402


class Ok(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"ok")

    def log_message(self, *args):
        pass


def test_health_all_up():
    srv = HTTPServer(("127.0.0.1", 0), Ok)
    port = srv.server_address[1]
    t = threading.Thread(target=srv.serve_forever, daemon=True)
    t.start()
    try:
        server.PORTS = [port]
        result = server.health()
        assert result["all_up"] is True
        assert result["labs"][0]["http"] == 200
    finally:
        srv.shutdown()


def test_health_down_port():
    server.PORTS = [18999]
    result = server.health()
    assert result["all_up"] is False
    assert result["labs"][0]["up"] is False
