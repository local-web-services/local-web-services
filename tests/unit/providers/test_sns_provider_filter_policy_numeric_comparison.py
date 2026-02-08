"""Tests for the SNS provider (P1-17 through P1-21)."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx

from ldk.interfaces import ICompute, InvocationResult
from ldk.interfaces.queue import IQueue
from ldk.providers.sns.filter import matches_filter_policy
from ldk.providers.sns.provider import (
    SnsProvider,
    TopicConfig,
)

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_compute_mock(payload: dict | None = None, error: str | None = None) -> ICompute:
    """Return a mock ICompute whose ``invoke`` resolves to the given result."""
    mock = AsyncMock(spec=ICompute)
    mock.invoke.return_value = InvocationResult(
        payload=payload,
        error=error,
        duration_ms=1.0,
        request_id="test-request-id",
    )
    return mock


def _make_queue_mock() -> IQueue:
    """Return a mock IQueue."""
    mock = AsyncMock(spec=IQueue)
    mock.send_message.return_value = "mock-sqs-message-id"
    return mock


def _topic_configs() -> list[TopicConfig]:
    return [
        TopicConfig(
            topic_name="my-topic",
            topic_arn="arn:aws:sns:us-east-1:000000000000:my-topic",
        ),
        TopicConfig(
            topic_name="other-topic",
            topic_arn="arn:aws:sns:us-east-1:000000000000:other-topic",
        ),
    ]


async def _started_provider(
    topics: list[TopicConfig] | None = None,
) -> SnsProvider:
    provider = SnsProvider(topics=topics or _topic_configs())
    await provider.start()
    return provider


def _client(app) -> httpx.AsyncClient:
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


# ===========================================================================
# LocalTopic tests
# ===========================================================================


# ===========================================================================
# SnsProvider lifecycle tests
# ===========================================================================


# ===========================================================================
# SnsProvider publish and subscribe
# ===========================================================================


# ===========================================================================
# Lambda subscription dispatch
# ===========================================================================


# ===========================================================================
# SQS subscription dispatch
# ===========================================================================


# ===========================================================================
# Fan-out to multiple subscribers
# ===========================================================================


# ===========================================================================
# Filter policy matching tests
# ===========================================================================


# ===========================================================================
# SNS event format construction
# ===========================================================================


# ===========================================================================
# SNS routes tests (wire protocol)
# ===========================================================================


class TestFilterPolicyNumericComparison:
    """Test numeric comparison in filter policies."""

    def test_greater_than_or_equal(self) -> None:
        attrs = {"price": {"DataType": "Number", "StringValue": "150"}}
        policy = {"price": [{"numeric": [">=", 100]}]}
        assert matches_filter_policy(attrs, policy) is True

    def test_less_than(self) -> None:
        attrs = {"price": {"DataType": "Number", "StringValue": "50"}}
        policy = {"price": [{"numeric": [">=", 100]}]}
        assert matches_filter_policy(attrs, policy) is False

    def test_range(self) -> None:
        attrs = {"price": {"DataType": "Number", "StringValue": "150"}}
        policy = {"price": [{"numeric": [">=", 100, "<", 200]}]}
        assert matches_filter_policy(attrs, policy) is True

    def test_range_out_of_bounds(self) -> None:
        attrs = {"price": {"DataType": "Number", "StringValue": "250"}}
        policy = {"price": [{"numeric": [">=", 100, "<", 200]}]}
        assert matches_filter_policy(attrs, policy) is False

    def test_numeric_equality(self) -> None:
        attrs = {"count": {"DataType": "Number", "StringValue": "42"}}
        policy = {"count": [{"numeric": ["=", 42]}]}
        assert matches_filter_policy(attrs, policy) is True
