"""Unit tests for the LDK request flow tracer."""

from __future__ import annotations

from lws.logging.tracer import Span


class TestSpan:
    """Tests for Span dataclass."""

    def test_span_has_id(self):
        # Arrange
        expected_span_id_length = 12

        # Act
        span = Span(name="test")

        # Assert
        assert span.span_id, "Expected value to be truthy"
        actual_span_id_length = len(span.span_id)
        assert actual_span_id_length == expected_span_id_length, f"Expected {expected_span_id_length!r} but got {actual_span_id_length!r}"

    def test_span_duration_zero_when_not_ended(self):
        span = Span(name="test")
        assert span.duration_ms == 0.0, f"Expected {0.0!r} but got {span.duration_ms!r}"

    def test_span_duration_calculated(self):
        # Arrange
        expected_duration_ms = 50.0
        tolerance = 0.01

        # Act
        span = Span(name="test", start_time=100.0, end_time=100.05)

        # Assert
        actual_duration_ms = span.duration_ms
        assert abs(actual_duration_ms - expected_duration_ms) < tolerance, f"Expected {abs(actual_duration_ms - expected_duration_ms)!r} < {tolerance!r}"

    def test_span_children_default_empty(self):
        span = Span(name="test")
        assert span.children == [], f"Expected {[]!r} but got {span.children!r}"

    def test_span_attributes_default_empty(self):
        span = Span(name="test")
        assert span.attributes == {}, "Expected {0!r} but got {1!r}".format({}, span.attributes)
