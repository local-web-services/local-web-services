# Change: Add web GUI dashboard to ldk dev

## Why
Developers currently rely on terminal logs and CLI commands to understand what is happening in their local LDK environment. A browser-based dashboard served at `/_ldk/gui` would provide real-time log streaming, resource exploration, and one-click operation invocation — all without leaving the browser.

## What Changes
- Add a WebSocket endpoint at `/_ldk/ws/logs` that streams structured log entries in real time
- Add a log capture handler to the logging system that buffers recent entries and publishes to connected WebSocket clients
- Add a `GET /_ldk/gui` endpoint that serves a self-contained HTML page (no build step, no frontend framework)
- The GUI page provides three capabilities:
  1. **Live logs** — real-time scrolling log view via WebSocket
  2. **Resource explorer** — browse all services and their resources (fetched from `/_ldk/resources` and `/_ldk/status`)
  3. **Operation invocation** — execute the operations from the Local Details column (the same commands available via `lws` CLI) and display results inline

## Impact
- Affected specs: `cli` (new management API endpoints and GUI serving), `logging` (new log capture handler for streaming)
- Affected code: `src/ldk/api/management.py`, `src/ldk/logging/logger.py`, new `src/ldk/api/gui.py`
