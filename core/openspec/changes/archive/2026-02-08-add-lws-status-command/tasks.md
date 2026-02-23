## 1. Implementation
- [x] 1.1 Add `lws status` command in `src/lws/cli/lws.py` that queries `GET /_ldk/status` and `GET /_ldk/resources`
- [x] 1.2 Display overall LDK status (running / not reachable)
- [x] 1.3 Display provider table with name and health status
- [x] 1.4 Display service table with name, port, and resource count
- [x] 1.5 Handle connection error when `ldk dev` is not running

## 2. Testing
- [x] 2.1 Add unit test for `lws status` output formatting
- [x] 2.2 Add integration test that starts `ldk dev`, runs `lws status`, and verifies output
