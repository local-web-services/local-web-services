"""Request flow tracing for LDK.

Provides a ``Tracer`` that builds a hierarchical span tree across an entire
request flow -- from the initial API Gateway request through Lambda invocation
and downstream SDK calls.  Uses ``contextvars`` for propagation so spans are
automatically linked even across async boundaries.
"""

from __future__ import annotations

import time
import uuid
from contextvars import ContextVar
from dataclasses import dataclass, field

from ldk.logging.logger import get_logger

_logger = get_logger("ldk.tracer")


@dataclass
class Span:
    """A single span in a trace tree.

    Attributes:
        span_id: Unique identifier for this span.
        name: Human-readable name (e.g. ``"POST /orders"``, ``"DynamoDB PutItem"``).
        start_time: Monotonic start time.
        end_time: Monotonic end time (set when the span is ended).
        children: Child spans triggered within this span's scope.
        attributes: Arbitrary key/value metadata.
    """

    span_id: str = field(default_factory=lambda: uuid.uuid4().hex[:12])
    name: str = ""
    start_time: float = field(default_factory=time.monotonic)
    end_time: float = 0.0
    children: list[Span] = field(default_factory=list)
    attributes: dict[str, str] = field(default_factory=dict)

    @property
    def duration_ms(self) -> float:
        """Return duration in milliseconds, or 0 if not yet ended."""
        if self.end_time <= 0:
            return 0.0
        return (self.end_time - self.start_time) * 1000


@dataclass
class TraceContext:
    """Root trace context containing the full span tree.

    Attributes:
        trace_id: Unique identifier for this trace.
        root_span: The top-level span.
        current_span: The currently active span (for nesting).
    """

    trace_id: str = field(default_factory=lambda: uuid.uuid4().hex[:16])
    root_span: Span | None = None
    current_span: Span | None = None


# Context variable that propagates the current trace across async tasks.
_current_trace: ContextVar[TraceContext | None] = ContextVar("current_trace", default=None)


class Tracer:
    """Trace builder that creates hierarchical span trees.

    Spans are automatically nested: calling ``start_span`` while another
    span is active adds the new span as a child of the current one.

    Usage::

        tracer = Tracer()
        root = tracer.start_trace("POST /orders")
        child = tracer.start_span("DynamoDB PutItem")
        tracer.end_span(child)
        tracer.end_trace()  # prints the tree
    """

    def start_trace(self, name: str) -> Span:
        """Begin a new trace and set it as the current context.

        Args:
            name: Name for the root span.

        Returns:
            The root ``Span``.
        """
        ctx = TraceContext()
        root = Span(name=name)
        ctx.root_span = root
        ctx.current_span = root
        _current_trace.set(ctx)
        return root

    def start_span(self, name: str) -> Span:
        """Start a new child span under the current active span.

        If no trace is active, a new trace is implicitly started.

        Args:
            name: Human-readable span name.

        Returns:
            The new ``Span``.
        """
        ctx = _current_trace.get(None)
        if ctx is None:
            return self.start_trace(name)

        span = Span(name=name)
        if ctx.current_span is not None:
            ctx.current_span.children.append(span)
        ctx.current_span = span
        return span

    def end_span(self, span: Span) -> None:
        """End a span, recording its end time.

        After ending, the tracer walks back to the parent span (if any)
        so that subsequent ``start_span`` calls nest correctly.

        Args:
            span: The span to end.
        """
        span.end_time = time.monotonic()
        ctx = _current_trace.get(None)
        if ctx is None:
            return

        # Walk back to the parent of this span
        parent = self._find_parent(ctx.root_span, span)
        if parent is not None:
            ctx.current_span = parent
        elif ctx.root_span is span:
            ctx.current_span = span

    def end_trace(self) -> TraceContext | None:
        """End the current trace and display the span tree.

        Returns:
            The completed ``TraceContext``, or ``None`` if no trace was active.
        """
        ctx = _current_trace.get(None)
        if ctx is None:
            return None

        if ctx.root_span is not None and ctx.root_span.end_time <= 0:
            ctx.root_span.end_time = time.monotonic()

        self._display_trace(ctx)
        _current_trace.set(None)
        return ctx

    def get_current_context(self) -> TraceContext | None:
        """Return the active ``TraceContext``, or ``None``."""
        return _current_trace.get(None)

    # ------------------------------------------------------------------
    # Display
    # ------------------------------------------------------------------

    def _display_trace(self, ctx: TraceContext) -> None:
        """Print the span tree with timing information."""
        if ctx.root_span is None:
            return
        _logger.info("Trace %s:", ctx.trace_id)
        self._display_span(ctx.root_span, depth=0)

    def _display_span(self, span: Span, depth: int) -> None:
        """Recursively display a span and its children."""
        indent = "  " * depth
        duration = f"{span.duration_ms:.0f}ms" if span.end_time > 0 else "running"
        _logger.info("%s%s (%s)", indent, span.name, duration)
        for child in span.children:
            self._display_span(child, depth + 1)

    # ------------------------------------------------------------------
    # Tree navigation
    # ------------------------------------------------------------------

    def _find_parent(self, root: Span | None, target: Span) -> Span | None:
        """Find the parent of *target* in the tree rooted at *root*.

        Returns ``None`` if *target* is the root or not found.
        """
        if root is None:
            return None
        for child in root.children:
            if child is target:
                return root
            found = self._find_parent(child, target)
            if found is not None:
                return found
        return None
