"""Structured logging framework for LDK.

Provides ``LdkLogger``, a wrapper around Python's standard logging module
that formats AWS service calls (HTTP/API Gateway, SQS, DynamoDB) into
concise, colour-coded single-line summaries using Rich console output.
"""

from __future__ import annotations

import asyncio
import logging
from collections import deque
from datetime import datetime
from typing import Any

from rich.console import Console

_console = Console(stderr=True)

# Global log handler for WebSocket streaming; set by _run_dev at startup.
_ws_handler: WebSocketLogHandler | None = None

# Mapping from log level name to Rich style for the level badge
_LEVEL_STYLES: dict[str, str] = {
    "DEBUG": "dim",
    "INFO": "cyan",
    "WARNING": "yellow",
    "ERROR": "bold red",
    "CRITICAL": "bold white on red",
}


def _status_style(status: str) -> str:
    """Return a Rich style string for a status or HTTP status code."""
    if status.startswith("2") or status == "OK":
        return "green"
    if status.startswith("4"):
        return "yellow"
    if status.startswith("5") or status == "ERROR":
        return "red"
    return "white"


def _timestamp() -> str:
    """Return the current time as HH:MM:SS."""
    return datetime.now().strftime("%H:%M:%S")


class WebSocketLogHandler:
    """Captures structured log entries and publishes them to WebSocket clients.

    Maintains a bounded deque of recent entries.  On each new entry every
    connected client queue receives the message.  New clients get the full
    backlog first.
    """

    def __init__(self, max_buffer: int = 500) -> None:
        self._buffer: deque[dict[str, Any]] = deque(maxlen=max_buffer)
        self._clients: list[asyncio.Queue[dict[str, Any]]] = []

    def emit(self, entry: dict[str, Any]) -> None:
        """Buffer *entry* and publish to all connected client queues."""
        self._buffer.append(entry)
        for q in self._clients:
            try:
                q.put_nowait(entry)
            except asyncio.QueueFull:
                pass  # drop if client is too slow

    def subscribe(self) -> asyncio.Queue[dict[str, Any]]:
        """Create a new client queue and return it (caller reads from it)."""
        q: asyncio.Queue[dict[str, Any]] = asyncio.Queue(maxsize=1000)
        self._clients.append(q)
        return q

    def unsubscribe(self, q: asyncio.Queue[dict[str, Any]]) -> None:
        """Remove a client queue."""
        try:
            self._clients.remove(q)
        except ValueError:
            pass

    def backlog(self) -> list[dict[str, Any]]:
        """Return a copy of the current buffer."""
        return list(self._buffer)


def _emit_to_ws(entry: dict[str, Any]) -> None:
    """Send a structured entry to the global WebSocket handler, if set."""
    if _ws_handler is not None:
        _ws_handler.emit(entry)


def set_ws_handler(handler: WebSocketLogHandler | None) -> None:
    """Set the global WebSocket log handler."""
    global _ws_handler  # noqa: PLW0603
    _ws_handler = handler


def get_ws_handler() -> WebSocketLogHandler | None:
    """Return the global WebSocket log handler."""
    return _ws_handler


class LdkLogger:
    """Structured logger wrapping Python's ``logging.Logger``.

    Formats AWS service invocations into compact, coloured log lines.
    Uses Rich console for colour output and Python logging for level filtering.

    Args:
        name: Logger name (passed to ``logging.getLogger``).
    """

    def __init__(self, name: str) -> None:
        self._logger = logging.getLogger(name)

    @property
    def level(self) -> int:
        """Return the effective log level."""
        return self._logger.getEffectiveLevel()

    def set_level(self, level: str) -> None:
        """Set the log level from a string like ``'debug'`` or ``'INFO'``."""
        self._logger.setLevel(getattr(logging, level.upper(), logging.INFO))

    # ------------------------------------------------------------------
    # Structured formatters
    # ------------------------------------------------------------------

    def log_http_request(
        self,
        method: str,
        path: str,
        handler_name: str,
        duration_ms: float,
        status_code: int,
        service: str | None = None,
        request_body: str | None = None,
        response_body: str | None = None,
    ) -> None:
        """Log an HTTP/API Gateway request.

        Format: ``[SERVICE] POST /orders -> createOrder (234ms) -> 201``
        """
        if not self._logger.isEnabledFor(logging.INFO):
            return
        status_str = str(status_code)
        style = _status_style(status_str)
        ts = _timestamp()

        # CLI output with service prefix
        service_prefix = f"[bold cyan]{service.upper()}[/bold cyan] " if service else ""
        _console.print(
            f"[dim][{ts}][/dim] {service_prefix}"
            f"[bold]{method}[/bold] {path} -> {handler_name} "
            f"({duration_ms:.0f}ms) -> [{style}]{status_code}[/{style}]"
        )

        # WebSocket output with full details
        entry = {
            "timestamp": ts,
            "level": "INFO",
            "message": (
                f"{service.upper()} {method} {path} -> {handler_name}"
                f" ({duration_ms:.0f}ms) -> {status_code}"
                if service
                else f"{method} {path} -> {handler_name} ({duration_ms:.0f}ms) -> {status_code}"
            ),
            "method": method,
            "path": path,
            "handler": handler_name,
            "duration_ms": duration_ms,
            "status_code": status_code,
        }
        if service:
            entry["service"] = service
        if request_body is not None:
            entry["request_body"] = request_body
        if response_body is not None:
            entry["response_body"] = response_body
        _emit_to_ws(entry)

    def log_sqs_invocation(
        self,
        queue_name: str,
        handler_name: str,
        message_count: int,
        duration_ms: float,
        status: str = "OK",
    ) -> None:
        """Log an SQS message processing invocation.

        Format: ``SQS OrderQueue -> processOrder (1 msg, 156ms) -> OK``
        """
        if not self._logger.isEnabledFor(logging.INFO):
            return
        style = _status_style(status)
        ts = _timestamp()
        msg_word = "msg" if message_count == 1 else "msgs"
        _console.print(
            f"[dim][{ts}][/dim] "
            f"[bold magenta]SQS[/bold magenta] {queue_name} -> {handler_name} "
            f"({message_count} {msg_word}, {duration_ms:.0f}ms) -> [{style}]{status}[/{style}]"
        )
        _emit_to_ws(
            {
                "timestamp": ts,
                "level": "INFO",
                "message": (
                    f"SQS {queue_name} -> {handler_name}"
                    f" ({message_count} {msg_word}, {duration_ms:.0f}ms) -> {status}"
                ),
                "service": "sqs",
                "queue": queue_name,
                "handler": handler_name,
                "duration_ms": duration_ms,
                "status": status,
            }
        )

    def log_dynamodb_operation(
        self,
        operation: str,
        table_name: str,
        duration_ms: float,
        status: str = "OK",
    ) -> None:
        """Log a DynamoDB SDK call.

        Format: ``DynamoDB PutItem orders (3ms) -> OK``
        """
        if not self._logger.isEnabledFor(logging.INFO):
            return
        style = _status_style(status)
        ts = _timestamp()
        _console.print(
            f"[dim][{ts}][/dim] "
            f"[bold blue]DynamoDB[/bold blue] {operation} {table_name} "
            f"({duration_ms:.0f}ms) -> [{style}]{status}[/{style}]"
        )
        _emit_to_ws(
            {
                "timestamp": ts,
                "level": "INFO",
                "message": f"DynamoDB {operation} {table_name} ({duration_ms:.0f}ms) -> {status}",
                "service": "dynamodb",
                "operation": operation,
                "table": table_name,
                "duration_ms": duration_ms,
                "status": status,
            }
        )

    def log_lambda_invocation(
        self,
        function_name: str,
        request_id: str,
        duration_ms: float,
        status: str = "OK",
        error: str | None = None,
        event: dict | None = None,
        context: dict | None = None,
        result: dict | None = None,
    ) -> None:
        """Log a Lambda function invocation.

        Format: ``LAMBDA ProcessOrderFunction (234ms) -> OK``
        """
        if not self._logger.isEnabledFor(logging.INFO):
            return
        style = _status_style(status)
        ts = _timestamp()
        _console.print(
            f"[dim][{ts}][/dim] "
            f"[bold green]LAMBDA[/bold green] {function_name} "
            f"({duration_ms:.0f}ms) -> [{style}]{status}[/{style}]"
        )
        entry: dict[str, Any] = {
            "timestamp": ts,
            "level": "ERROR" if status == "ERROR" else "INFO",
            "message": f"LAMBDA {function_name} ({duration_ms:.0f}ms) -> {status}",
            "service": "lambda",
            "handler": function_name,
            "request_id": request_id,
            "duration_ms": duration_ms,
            "status": status,
        }
        if event is not None or context is not None:
            import json

            try:
                request_data: dict[str, Any] = {}
                if event is not None:
                    request_data["event"] = event
                if context is not None:
                    request_data["context"] = context
                entry["request_body"] = json.dumps(request_data, default=str)[:10240]
            except Exception:
                pass
        if result is not None:
            import json

            try:
                entry["response_body"] = json.dumps(result, default=str)[:10240]
            except Exception:
                pass
        if error is not None:
            entry["error"] = error
        _emit_to_ws(entry)

    # ------------------------------------------------------------------
    # Standard log methods
    # ------------------------------------------------------------------

    def debug(self, message: str, *args: object) -> None:
        """Log a debug message."""
        if self._logger.isEnabledFor(logging.DEBUG):
            formatted = message % args if args else message
            ts = _timestamp()
            _console.print(f"[dim][{ts}] DEBUG {self._logger.name}: {formatted}[/dim]")
            _emit_to_ws({"timestamp": ts, "level": "DEBUG", "message": formatted})

    def info(self, message: str, *args: object) -> None:
        """Log an info message."""
        if self._logger.isEnabledFor(logging.INFO):
            formatted = message % args if args else message
            ts = _timestamp()
            _console.print(f"[dim][{ts}][/dim] [cyan]INFO[/cyan] {self._logger.name}: {formatted}")
            _emit_to_ws({"timestamp": ts, "level": "INFO", "message": formatted})

    def warning(self, message: str, *args: object) -> None:
        """Log a warning message."""
        if self._logger.isEnabledFor(logging.WARNING):
            formatted = message % args if args else message
            ts = _timestamp()
            _console.print(
                f"[dim][{ts}][/dim] [yellow]WARN[/yellow] {self._logger.name}: {formatted}"
            )
            _emit_to_ws({"timestamp": ts, "level": "WARNING", "message": formatted})

    def error(self, message: str, *args: object) -> None:
        """Log an error message."""
        if self._logger.isEnabledFor(logging.ERROR):
            formatted = message % args if args else message
            ts = _timestamp()
            _console.print(
                f"[dim][{ts}][/dim] [bold red]ERROR[/bold red] {self._logger.name}: {formatted}"
            )
            _emit_to_ws({"timestamp": ts, "level": "ERROR", "message": formatted})

    def is_enabled_for(self, level: int) -> bool:
        """Check if the logger is enabled for the given level."""
        return self._logger.isEnabledFor(level)


def get_logger(name: str) -> LdkLogger:
    """Factory function to create an ``LdkLogger`` instance.

    Args:
        name: Logger name, typically a dotted module path like ``ldk.runtime``.

    Returns:
        A configured ``LdkLogger`` instance.
    """
    return LdkLogger(name)
