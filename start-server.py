#!/usr/bin/env python3
"""
Simple HTTP server to run the Framer project locally.
"""
import http.server
import socketserver
import os
import webbrowser
from pathlib import Path

PORT = 8000

# Change to the project root directory
os.chdir(Path(__file__).parent)

Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    url = f"http://localhost:{PORT}/imaginative-screens-471831.framer.app/"
    print(f"Server running at {url}")
    print("Press Ctrl+C to stop the server")
    print("\nOpening browser...")
    webbrowser.open(url)
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n\nServer stopped.")

