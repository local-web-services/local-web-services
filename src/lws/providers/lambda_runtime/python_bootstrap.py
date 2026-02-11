"""Bootstrap script for Python Lambda handlers.

This module is executed as a subprocess by :class:`PythonCompute`.  It reads
the event from stdin, loads the user-supplied handler, invokes it with a
:class:`LambdaContext`, and writes the JSON result to stdout.

Environment variables consumed:

    LDK_HANDLER       Handler spec, e.g. ``"handler.main"``
    LDK_CODE_PATH     Absolute path to the directory containing handler code
    LDK_REQUEST_ID    Unique request identifier
    LDK_FUNCTION_ARN  Invoked function ARN
    LDK_TIMEOUT       Timeout in seconds (used for context countdown)
    LDK_DEBUG_PORT    (optional) debugpy listen port
"""

from __future__ import annotations

import importlib
import json
import os
import sys
import time


def _build_context() -> dict:
    """Build a lightweight context object mirroring AWS Lambda context."""
    function_name = os.environ.get("AWS_LAMBDA_FUNCTION_NAME", "local-function")
    memory_mb = int(os.environ.get("AWS_LAMBDA_FUNCTION_MEMORY_SIZE", "128"))
    timeout = float(os.environ.get("LDK_TIMEOUT", "3"))
    request_id = os.environ.get("LDK_REQUEST_ID", "local-request-id")
    function_arn = os.environ.get(
        "LDK_FUNCTION_ARN",
        "arn:ldk:lambda:local:000000000000:function:local",
    )

    start_time = time.monotonic()

    class Context:
        """Minimal Lambda context object with countdown timer."""

        def __init__(self) -> None:
            self.function_name = function_name
            self.function_version = "$LATEST"
            self.memory_limit_in_mb = memory_mb
            self.log_group_name = f"/aws/lambda/{function_name}"
            self.log_stream_name = "local"
            self.aws_request_id = request_id
            self.invoked_function_arn = function_arn

        def get_remaining_time_in_millis(self) -> int:
            elapsed = time.monotonic() - start_time
            remaining = max(0, timeout - elapsed)
            return int(remaining * 1000)

    return Context()


def _load_handler(handler_spec: str, code_path: str):
    """Import the handler module and return the handler function."""
    last_dot = handler_spec.rfind(".")
    if last_dot == -1:
        raise ValueError(f"Invalid handler format '{handler_spec}': expected 'module.function'")

    module_name = handler_spec[:last_dot]
    function_name = handler_spec[last_dot + 1 :]

    # Add code_path to sys.path so the handler module can be imported.
    if code_path not in sys.path:
        sys.path.insert(0, code_path)

    module = importlib.import_module(module_name)
    handler_fn = getattr(module, function_name, None)

    if handler_fn is None:
        raise AttributeError(
            f"Handler function '{function_name}' not found in module '{module_name}'"
        )

    return handler_fn


def _maybe_attach_debugger() -> None:
    """If LDK_DEBUG_PORT is set, wait for a debugpy connection."""
    debug_port = os.environ.get("LDK_DEBUG_PORT")
    if not debug_port:
        return
    try:
        import debugpy  # type: ignore[import-untyped]

        debugpy.listen(("0.0.0.0", int(debug_port)))
        debugpy.wait_for_client()
    except ImportError:
        # debugpy not installed -- silently skip
        pass


def main() -> None:
    """Entry point for the bootstrap script."""
    try:
        handler_spec = os.environ.get("LDK_HANDLER", "")
        code_path = os.environ.get("LDK_CODE_PATH", "")

        if not handler_spec:
            raise ValueError("LDK_HANDLER environment variable is required")
        if not code_path:
            raise ValueError("LDK_CODE_PATH environment variable is required")

        _maybe_attach_debugger()

        # Read event JSON from stdin.
        event_json = sys.stdin.read()
        event = json.loads(event_json)

        # Build context and load handler.
        context = _build_context()
        handler_fn = _load_handler(handler_spec, code_path)

        # Invoke the handler.
        result = handler_fn(event, context)

        # Write result to stdout and flush before exiting.
        sys.stdout.write(json.dumps({"result": result}))
        sys.stdout.flush()
        sys.exit(0)

    except Exception as exc:
        error_payload = {
            "error": {
                "errorMessage": str(exc),
                "errorType": type(exc).__name__,
            }
        }
        sys.stdout.write(json.dumps(error_payload))
        sys.exit(1)


if __name__ == "__main__":
    main()
