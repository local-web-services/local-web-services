## Context
LDK currently outputs structured logs to the terminal via Rich and exposes management API endpoints for status, resources, invoke, and reset. There is no browser-based interface. The GUI must be zero-dependency from the user's perspective — no npm, no build step, no extra install.

## Goals / Non-Goals
- Goals:
  - Serve a single self-contained HTML page at `/_ldk/gui` with inline CSS and JS
  - Stream logs in real time via WebSocket at `/_ldk/ws/logs`
  - Let users browse resources and invoke operations from the browser
  - Reuse existing management API endpoints (`/_ldk/resources`, `/_ldk/status`, `/_ldk/invoke`)
- Non-Goals:
  - Not building a production-grade SPA — this is a developer tool dashboard
  - Not adding authentication — LDK is local-only
  - Not replacing the CLI or terminal logs — the GUI is a complement

## Decisions

### Log capture and streaming
- **Decision:** Add a `WebSocketLogHandler` that receives structured log records from `LdkLogger` and publishes them to all connected WebSocket clients.
- **Alternatives considered:**
  - SSE (Server-Sent Events): simpler but one-directional; WebSocket allows future client-side filtering
  - Polling a log history endpoint: adds latency and complexity; WebSocket is real-time
- **Implementation:** The handler maintains a bounded deque of recent log entries (e.g. 500). On WebSocket connect, the backlog is sent first, then new entries stream as they arrive. Each log entry is a JSON object with `timestamp`, `level`, `message`, and optional structured fields (`method`, `path`, `handler`, `duration_ms`, `status_code`, `service`, `operation`, `table`, `error`).

### GUI serving
- **Decision:** A single Python module (`src/lws/api/gui.py`) returns an `HTMLResponse` with the full dashboard inlined — HTML, CSS, and JS in one response.
- **Alternatives considered:**
  - Static files directory with `StaticFiles`: adds file management complexity for a single page
  - CDN-loaded framework (React, Vue): adds external dependency and network requirement
- **Rationale:** A single HTML response is the simplest approach that works offline. Vanilla JS with `fetch()` and `WebSocket` is sufficient for the three features.

### Operation invocation from the GUI
- **Decision:** The GUI calls the same wire-protocol endpoints that `lws` CLI commands use. The frontend JS sends requests directly to service ports (discovered via `/_ldk/resources`).
- **Alternatives considered:**
  - Proxying all operations through a new management API endpoint: adds a middle layer with no benefit since all ports are on localhost
- **Rationale:** Direct calls to service ports match how `lws` works and avoid adding proxy complexity. The `/_ldk/resources` endpoint provides all the port and resource metadata needed.

### GUI page structure
- Three tabs/sections:
  1. **Logs** — auto-scrolling log viewer with level-based color coding, pause/resume button
  2. **Resources** — accordion/card layout grouped by service, showing resource details and action buttons
  3. **Invoke** — when an action button is clicked, a panel shows the operation form, executes it, and displays the JSON result

## Risks / Trade-offs
- Large inline HTML response: acceptable for a developer tool; the page will be <100KB
- No hot reload of GUI itself: changes to the HTML require restarting `ldk dev`; acceptable since this is not user code
- WebSocket connections consume memory: bounded deque and connection cleanup mitigate this

## Open Questions
- None — design is scoped to minimum viable dashboard
