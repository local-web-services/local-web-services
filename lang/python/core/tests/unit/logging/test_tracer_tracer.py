"""Unit tests for the LDK request flow tracer."""

from __future__ import annotations

import time

from lws.logging.tracer import Tracer


class TestTracer:
    """Tests for Tracer span creation and hierarchy."""

    def test_start_trace_creates_root_span(self):
        # Arrange
        expected_name = "root"
        tracer = Tracer()

        # Act
        root = tracer.start_trace(expected_name)

        # Assert
        actual_name = root.name
        assert actual_name == expected_name
        assert root.start_time > 0

    def test_start_trace_sets_context(self):
        # Arrange
        expected_name = "root"
        tracer = Tracer()

        # Act
        tracer.start_trace(expected_name)
        ctx = tracer.get_current_context()

        # Assert
        assert ctx is not None
        assert ctx.root_span is not None
        actual_name = ctx.root_span.name
        assert actual_name == expected_name
        # Clean up
        tracer.end_trace()

    def test_start_span_creates_child(self):
        # Arrange
        expected_child_name = "child"
        expected_child_count = 1
        tracer = Tracer()
        root = tracer.start_trace("root")

        # Act
        child = tracer.start_span(expected_child_name)

        # Assert
        actual_child_name = child.name
        actual_child_count = len(root.children)
        assert actual_child_name == expected_child_name
        assert actual_child_count == expected_child_count
        assert root.children[0] is child
        tracer.end_trace()

    def test_nested_spans(self):
        # Arrange
        expected_child_count = 1
        tracer = Tracer()
        root = tracer.start_trace("root")

        # Act
        child = tracer.start_span("child")
        grandchild = tracer.start_span("grandchild")

        # Assert
        assert len(root.children) == expected_child_count
        assert len(child.children) == expected_child_count
        assert child.children[0] is grandchild

        tracer.end_trace()

    def test_end_span_records_end_time(self):
        tracer = Tracer()
        tracer.start_trace("root")
        child = tracer.start_span("child")
        time.sleep(0.01)
        tracer.end_span(child)

        assert child.end_time > child.start_time
        assert child.duration_ms > 0
        tracer.end_trace()

    def test_end_span_returns_to_parent(self):
        # Arrange
        expected_child_count = 2
        tracer = Tracer()
        root = tracer.start_trace("root")
        child = tracer.start_span("child")
        tracer.end_span(child)

        # Act — after ending child, next span should be added to root
        sibling = tracer.start_span("sibling")

        # Assert
        actual_child_count = len(root.children)
        assert actual_child_count == expected_child_count
        assert root.children[1] is sibling
        tracer.end_trace()

    def test_end_trace_clears_context(self):
        tracer = Tracer()
        tracer.start_trace("root")
        result = tracer.end_trace()

        assert result is not None
        assert result.root_span is not None
        assert result.root_span.end_time > 0

        # Context should be cleared
        assert tracer.get_current_context() is None

    def test_end_trace_returns_none_when_no_trace(self):
        tracer = Tracer()
        assert tracer.end_trace() is None

    def test_start_span_without_trace_creates_implicit_trace(self):
        # Arrange
        expected_name = "implicit"
        tracer = Tracer()

        # Act
        span = tracer.start_span(expected_name)

        # Assert
        actual_name = span.name
        assert actual_name == expected_name
        ctx = tracer.get_current_context()
        assert ctx is not None
        assert ctx.root_span is span
        tracer.end_trace()

    def test_multiple_children_at_same_level(self):
        # Arrange
        expected_child1_name = "child1"
        expected_child2_name = "child2"
        expected_child3_name = "child3"
        expected_child_count = 3
        tracer = Tracer()
        root = tracer.start_trace("root")

        # Act
        child1 = tracer.start_span(expected_child1_name)
        tracer.end_span(child1)

        child2 = tracer.start_span(expected_child2_name)
        tracer.end_span(child2)

        child3 = tracer.start_span(expected_child3_name)
        tracer.end_span(child3)

        # Assert
        actual_child_count = len(root.children)
        assert actual_child_count == expected_child_count
        assert root.children[0].name == expected_child1_name
        assert root.children[1].name == expected_child2_name
        assert root.children[2].name == expected_child3_name

        tracer.end_trace()

    def test_trace_context_propagation(self):
        """Verify that trace context is propagated via contextvars."""
        # Arrange
        expected_child_count = 2
        tracer = Tracer()
        tracer.start_trace("request")

        # Act — simulate nested SDK calls
        db_span = tracer.start_span("DynamoDB PutItem")
        tracer.end_span(db_span)

        sqs_span = tracer.start_span("SQS SendMessage")
        tracer.end_span(sqs_span)

        # Assert
        ctx = tracer.get_current_context()
        assert ctx is not None
        assert ctx.root_span is not None
        actual_child_count = len(ctx.root_span.children)
        assert actual_child_count == expected_child_count

        result = tracer.end_trace()
        assert result is not None
        assert result.root_span.duration_ms >= 0
