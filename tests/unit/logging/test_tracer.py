"""Unit tests for the LDK request flow tracer."""

from __future__ import annotations

import time

from ldk.logging.tracer import Span, TraceContext, Tracer


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


class TestTracer:
    """Tests for Tracer span creation and hierarchy."""

    def test_start_trace_creates_root_span(self):
        tracer = Tracer()
        root = tracer.start_trace("root")
        assert root.name == "root"
        assert root.start_time > 0

    def test_start_trace_sets_context(self):
        tracer = Tracer()
        tracer.start_trace("root")
        ctx = tracer.get_current_context()
        assert ctx is not None
        assert ctx.root_span is not None
        assert ctx.root_span.name == "root"
        # Clean up
        tracer.end_trace()

    def test_start_span_creates_child(self):
        tracer = Tracer()
        root = tracer.start_trace("root")
        child = tracer.start_span("child")
        assert child.name == "child"
        assert len(root.children) == 1
        assert root.children[0] is child
        tracer.end_trace()

    def test_nested_spans(self):
        tracer = Tracer()
        root = tracer.start_trace("root")
        child = tracer.start_span("child")
        grandchild = tracer.start_span("grandchild")

        assert len(root.children) == 1
        assert len(child.children) == 1
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
        tracer = Tracer()
        root = tracer.start_trace("root")
        child = tracer.start_span("child")
        tracer.end_span(child)

        # After ending child, next span should be added to root
        sibling = tracer.start_span("sibling")
        assert len(root.children) == 2
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
        tracer = Tracer()
        span = tracer.start_span("implicit")
        assert span.name == "implicit"

        ctx = tracer.get_current_context()
        assert ctx is not None
        assert ctx.root_span is span
        tracer.end_trace()

    def test_multiple_children_at_same_level(self):
        tracer = Tracer()
        root = tracer.start_trace("root")

        child1 = tracer.start_span("child1")
        tracer.end_span(child1)

        child2 = tracer.start_span("child2")
        tracer.end_span(child2)

        child3 = tracer.start_span("child3")
        tracer.end_span(child3)

        assert len(root.children) == 3
        assert root.children[0].name == "child1"
        assert root.children[1].name == "child2"
        assert root.children[2].name == "child3"

        tracer.end_trace()

    def test_trace_context_propagation(self):
        """Verify that trace context is propagated via contextvars."""
        tracer = Tracer()
        tracer.start_trace("request")

        # Simulate nested SDK calls
        db_span = tracer.start_span("DynamoDB PutItem")
        tracer.end_span(db_span)

        sqs_span = tracer.start_span("SQS SendMessage")
        tracer.end_span(sqs_span)

        ctx = tracer.get_current_context()
        assert ctx is not None
        assert ctx.root_span is not None
        assert len(ctx.root_span.children) == 2

        result = tracer.end_trace()
        assert result is not None
        assert result.root_span.duration_ms >= 0
