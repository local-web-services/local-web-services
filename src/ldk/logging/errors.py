"""Error logging with context for LDK handler failures.

Provides ``log_handler_error`` which displays a structured, colour-coded
error report including the handler name, event source, a truncated event
payload, and the full stack trace.
"""

from __future__ import annotations

import json
import traceback as tb_module

from rich.console import Console
from rich.panel import Panel
from rich.text import Text

_console = Console(stderr=True)

# Maximum size of the event payload displayed in error output.
_MAX_EVENT_DISPLAY_BYTES = 1024


def _truncate_event(event: dict | str | None) -> str:
    """Return a JSON string of *event*, truncated to ``_MAX_EVENT_DISPLAY_BYTES``.

    Args:
        event: The event payload to truncate.

    Returns:
        A (possibly truncated) JSON string representation.
    """
    if event is None:
        return "<no event>"
    try:
        text = json.dumps(event, indent=2, default=str)
    except (TypeError, ValueError):
        text = str(event)

    if len(text) > _MAX_EVENT_DISPLAY_BYTES:
        return text[:_MAX_EVENT_DISPLAY_BYTES] + "\n... (truncated)"
    return text


def _format_traceback(error: BaseException | None, traceback_str: str | None) -> str:
    """Build a traceback string from an exception and/or a raw traceback string.

    Args:
        error: The exception object (may be ``None``).
        traceback_str: A pre-formatted traceback string (e.g. from subprocess stderr).

    Returns:
        A combined traceback string.
    """
    parts: list[str] = []
    if traceback_str:
        parts.append(traceback_str.rstrip())
    if error is not None:
        formatted = tb_module.format_exception(type(error), error, error.__traceback__)
        parts.append("".join(formatted).rstrip())
    return "\n".join(parts) if parts else "<no traceback available>"


def log_handler_error(
    function_name: str,
    event_source: str,
    event: dict | str | None,
    error: BaseException | None,
    traceback_str: str | None = None,
) -> None:
    """Display a structured error report for a failed handler invocation.

    Shows the handler name, event source, a truncated event payload (max 1KB),
    and the full stack trace with red colouring.

    Args:
        function_name: Name of the Lambda handler that failed.
        event_source: Source of the event (e.g. ``"API Gateway"``, ``"SQS"``).
        event: The event payload that was passed to the handler.
        error: The exception that was raised (may be ``None`` for subprocess errors).
        traceback_str: Raw traceback text captured from subprocess stderr.
    """
    _console.print()

    # Header
    header = Text()
    header.append("Handler Error", style="bold red")
    header.append(f"  {function_name}", style="bold white")
    _console.print(header)

    # Event source
    _console.print(f"  [dim]Source:[/dim] {event_source}")

    # Error message
    error_msg = str(error) if error is not None else "Unknown error"
    _console.print(f"  [dim]Error:[/dim]  [red]{error_msg}[/red]")

    # Truncated event payload
    event_text = _truncate_event(event)
    _console.print("  [dim]Event:[/dim]")
    _console.print(f"  [dim]{event_text}[/dim]")

    # Stack trace
    tb_text = _format_traceback(error, traceback_str)
    panel = Panel(
        Text(tb_text, style="red"),
        title="Stack Trace",
        border_style="red",
        expand=False,
    )
    _console.print(panel)
    _console.print()
