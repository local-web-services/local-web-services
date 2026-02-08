"""SDK call instrumentation for tracking nested service calls.

Uses ``contextvars`` to associate SDK calls (DynamoDB, SQS, S3) with the
parent Lambda invocation that triggered them, enabling hierarchical logging
where SDK calls are visually indented under their parent request.
"""

from __future__ import annotations

import time
from contextvars import ContextVar
from dataclasses import dataclass, field

from ldk.logging.logger import LdkLogger, get_logger

_logger: LdkLogger = get_logger("ldk.instrumentation")

# Context variable holding the current invocation context (if any).
_current_invocation: ContextVar[InvocationContext | None] = ContextVar(
    "current_invocation", default=None
)


@dataclass
class SdkCall:
    """Record of a single SDK call made during an invocation."""

    service: str
    operation: str
    resource: str
    duration_ms: float
    status: str
    payload: dict | None = None


@dataclass
class InvocationContext:
    """Tracks a parent Lambda invocation and its child SDK calls.

    Stored in a ``ContextVar`` so async tasks that handle a single request
    can record SDK calls without explicit parameter threading.
    """

    request_id: str
    function_name: str
    start_time: float = field(default_factory=time.monotonic)
    sdk_calls: list[SdkCall] = field(default_factory=list)


def start_invocation(request_id: str, function_name: str) -> InvocationContext:
    """Begin tracking a new invocation and store it in the context var.

    Args:
        request_id: Unique request identifier.
        function_name: Name of the Lambda function being invoked.

    Returns:
        The newly created ``InvocationContext``.
    """
    ctx = InvocationContext(request_id=request_id, function_name=function_name)
    _current_invocation.set(ctx)
    return ctx


def end_invocation() -> InvocationContext | None:
    """End the current invocation and clear the context var.

    Returns:
        The completed ``InvocationContext``, or ``None`` if there was none.
    """
    ctx = _current_invocation.get(None)
    _current_invocation.set(None)
    return ctx


def get_current_invocation() -> InvocationContext | None:
    """Return the current ``InvocationContext``, or ``None``."""
    return _current_invocation.get(None)


def log_sdk_call(
    service: str,
    operation: str,
    resource: str,
    duration_ms: float,
    status: str,
    payload: dict | None = None,
) -> None:
    """Log an SDK call, associating it with the current invocation context.

    At INFO level the call is printed as an indented one-liner under the
    parent request.  At DEBUG level the full payload is also emitted.

    Args:
        service: AWS service name (e.g. ``"DynamoDB"``, ``"SQS"``, ``"S3"``).
        operation: Operation name (e.g. ``"PutItem"``, ``"SendMessage"``).
        resource: Resource identifier (table name, queue name, bucket, etc.).
        duration_ms: Duration of the call in milliseconds.
        status: Result status string (e.g. ``"OK"``, ``"ERROR"``).
        payload: Optional full request/response payload for DEBUG logging.
    """
    call = SdkCall(
        service=service,
        operation=operation,
        resource=resource,
        duration_ms=duration_ms,
        status=status,
        payload=payload,
    )

    ctx = _current_invocation.get(None)
    if ctx is not None:
        ctx.sdk_calls.append(call)

    # Indented logging under parent invocation
    _logger.info(
        "  -> %s %s %s (%0.fms) -> %s",
        service,
        operation,
        resource,
        duration_ms,
        status,
    )

    if payload is not None:
        _logger.debug("     payload: %s", payload)
