#!/usr/bin/env python3
"""Static dev server for dist/, with the MIME types Python misses on Windows."""
import functools
import http.server
import mimetypes
import sys
from pathlib import Path

for ext, mime in {
    ".webp": "image/webp",
    ".avif": "image/avif",
    ".svg": "image/svg+xml",
    ".woff2": "font/woff2",
}.items():
    mimetypes.add_type(mime, ext)


class Handler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        # Dev server: never let the browser cache a stale build.
        self.send_header("Cache-Control", "no-store")
        super().end_headers()


if __name__ == "__main__":
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 4321
    root = Path(__file__).parent / "dist"
    handler = functools.partial(Handler, directory=str(root))
    with http.server.ThreadingHTTPServer(("127.0.0.1", port), handler) as httpd:
        print(f"serving {root} at http://127.0.0.1:{port}", flush=True)
        httpd.serve_forever()
