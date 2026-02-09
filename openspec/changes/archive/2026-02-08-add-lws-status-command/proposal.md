# Change: Add `lws status` command

## Why
There is no way to check whether `ldk dev` is running and what state its providers are in without inspecting processes or curling the management API manually. A dedicated `lws status` command gives developers a quick, human-readable overview of the running environment.

## What Changes
- Add an `lws status` command that queries the management API (`GET /_ldk/status` and `GET /_ldk/resources`) and displays the results as a formatted table.
- Output shows: overall LDK running state, each provider with its health status, and each service with its port and resource count.
- Handles the case where `ldk dev` is not running with a clear error message.

## Impact
- Affected specs: `cli`
- Affected code: `src/lws/cli/lws.py`
