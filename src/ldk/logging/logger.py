"""Structured logging framework for LDK.

Provides ``LdkLogger``, a wrapper around Python's standard logging module
that formats AWS service calls (HTTP/API Gateway, SQS, DynamoDB) into
concise, colour-coded single-line summaries using Rich console output.
"""

from __future__ import annotations

import logging
from datetime import datetime

from rich.console import Console

_console = Console(stderr=True)

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
    ) -> None:
        """Log an HTTP/API Gateway request.

        Format: ``POST /orders -> createOrder (234ms) -> 201``
        """
        if not self._logger.isEnabledFor(logging.INFO):
            return
        status_str = str(status_code)
        style = _status_style(status_str)
        ts = _timestamp()
        _console.print(
            f"[dim][{ts}][/dim] "
            f"[bold]{method}[/bold] {path} -> {handler_name} "
            f"({duration_ms:.0f}ms) -> [{style}]{status_code}[/{style}]"
        )

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

    # ------------------------------------------------------------------
    # Standard log methods
    # ------------------------------------------------------------------

    def debug(self, message: str, *args: object) -> None:
        """Log a debug message."""
        if self._logger.isEnabledFor(logging.DEBUG):
            formatted = message % args if args else message
            ts = _timestamp()
            _console.print(f"[dim][{ts}] DEBUG {self._logger.name}: {formatted}[/dim]")

    def info(self, message: str, *args: object) -> None:
        """Log an info message."""
        if self._logger.isEnabledFor(logging.INFO):
            formatted = message % args if args else message
            ts = _timestamp()
            _console.print(f"[dim][{ts}][/dim] [cyan]INFO[/cyan] {self._logger.name}: {formatted}")

    def warning(self, message: str, *args: object) -> None:
        """Log a warning message."""
        if self._logger.isEnabledFor(logging.WARNING):
            formatted = message % args if args else message
            ts = _timestamp()
            _console.print(
                f"[dim][{ts}][/dim] [yellow]WARN[/yellow] {self._logger.name}: {formatted}"
            )

    def error(self, message: str, *args: object) -> None:
        """Log an error message."""
        if self._logger.isEnabledFor(logging.ERROR):
            formatted = message % args if args else message
            ts = _timestamp()
            _console.print(
                f"[dim][{ts}][/dim] [bold red]ERROR[/bold red] {self._logger.name}: {formatted}"
            )

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
