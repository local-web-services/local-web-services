## MODIFIED Requirements
### Requirement: Python Handler Execution
LDK SHALL execute Python Lambda handlers via subprocess using `asyncio.create_subprocess_exec` with a bootstrap script (`ldk/runtime/python_bootstrap.py`) that reads the serialized event from stdin, imports and invokes the handler function, and writes the JSON response to stdout. The Python executable path SHALL be configurable (default `python3`). When the `--inspect` flag is active, the subprocess SHALL start with debugpy listening on a per-function port (starting from base port 5678) to support remote debugger attachment.

#### Scenario: Invoke Python handler
- **WHEN** an event triggers a Python Lambda function
- **THEN** LDK SHALL spawn a Python subprocess via `asyncio.create_subprocess_exec`, pass the serialized event JSON via stdin to the bootstrap script, invoke the handler function, and return the deserialized JSON response from stdout

#### Scenario: Python handler error captured from subprocess
- **WHEN** a Python handler raises an exception during execution
- **THEN** LDK SHALL capture the subprocess stderr containing the Python traceback and return it as an invocation error with the non-zero exit code

#### Scenario: debugpy attachment for Python debugging
- **WHEN** `ldk dev --inspect` is active and a Python Lambda function is invoked
- **THEN** the Python subprocess SHALL start with debugpy listening on an allocated port and the terminal SHALL display the debugpy connection URL for the function
