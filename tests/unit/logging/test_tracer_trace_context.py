"""Unit tests for the LDK request flow tracer."""

from __future__ import annotations

from lws.logging.tracer import TraceContext


class TestTraceContext:
    """Tests for TraceContext dataclass."""

    def test_trace_has_id(self):
        # Arrange
        expected_trace_id_length = 16

        # Act
        ctx = TraceContext()

        # Assert
        assert ctx.trace_id
        actual_trace_id_length = len(ctx.trace_id)
        assert actual_trace_id_length == expected_trace_id_length

    def test_defaults_none(self):
        ctx = TraceContext()
        assert ctx.root_span is None
        assert ctx.current_span is None
