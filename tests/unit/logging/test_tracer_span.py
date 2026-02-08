"""Unit tests for the LDK request flow tracer."""

from __future__ import annotations

from ldk.logging.tracer import Span


class TestSpan:
    """Tests for Span dataclass."""

    def test_span_has_id(self):
        span = Span(name="test")
        assert span.span_id
        assert len(span.span_id) == 12

    def test_span_duration_zero_when_not_ended(self):
        span = Span(name="test")
        assert span.duration_ms == 0.0

    def test_span_duration_calculated(self):
        span = Span(name="test", start_time=100.0, end_time=100.05)
        assert abs(span.duration_ms - 50.0) < 0.01

    def test_span_children_default_empty(self):
        span = Span(name="test")
        assert span.children == []

    def test_span_attributes_default_empty(self):
        span = Span(name="test")
        assert span.attributes == {}
