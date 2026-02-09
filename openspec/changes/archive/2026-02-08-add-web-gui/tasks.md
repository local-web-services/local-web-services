## 1. Log capture and WebSocket streaming
- [ ] 1.1 Add `WebSocketLogHandler` to `src/lws/logging/logger.py` that captures structured log entries into a bounded deque and publishes to connected WebSocket clients
- [ ] 1.2 Add WebSocket endpoint `/_ldk/ws/logs` to the management API router in `src/lws/api/management.py`
- [ ] 1.3 Wire up the handler in `_run_dev()` so all `LdkLogger` instances publish to the WebSocket handler
- [ ] 1.4 Add unit tests for `WebSocketLogHandler` (buffering, publish, no-client case)
- [ ] 1.5 Add integration test for WebSocket log streaming (connect, receive backlog, receive live entry)

## 2. GUI HTML page and serving
- [ ] 2.1 Create `src/lws/api/gui.py` with a function that returns the dashboard HTML as an `HTMLResponse`
- [ ] 2.2 Add `GET /_ldk/gui` route to the management API router
- [ ] 2.3 Build the HTML page structure with three tabs: Logs, Resources, Invoke
- [ ] 2.4 Implement the Logs tab: WebSocket connection, auto-scroll, pause/resume, level-based color coding
- [ ] 2.5 Implement the Resources tab: fetch `/_ldk/resources` and `/_ldk/status`, display grouped by service with health status and port
- [ ] 2.6 Implement the Invoke tab: action buttons per resource, parameter forms per operation, execute via wire protocol, display JSON result
- [ ] 2.7 Add unit test that `GET /_ldk/gui` returns 200 with HTML content-type
- [ ] 2.8 Add integration test that dashboard loads and can reach the resources endpoint

## 3. Print GUI URL at startup
- [ ] 3.1 Update `_run_dev()` startup output to print the GUI URL alongside the existing "Ready! Listening on" message
