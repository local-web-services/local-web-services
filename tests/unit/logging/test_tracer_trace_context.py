"""Unit tests for the LDK request flow tracer."""

from __future__ import annotations

from lws.logging.tracer import TraceContext


class TestTraceContext:
    """Tests for TraceContext dataclass."""

    def test_trace_has_id(self):
        ctx = TraceContext()
        assert ctx.trace_id
        assert len(ctx.trace_id) == 16

    def test_defaults_none(self):
        ctx = TraceContext()
        assert ctx.root_span is None
        assert ctx.current_span is None
