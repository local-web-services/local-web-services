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


class TestFilterPolicyNoFilter:
    """Test that no filter policy matches everything."""

    def test_none_filter_matches_all(self) -> None:
        attrs = {"anything": {"DataType": "String", "StringValue": "value"}}
        assert matches_filter_policy(attrs, None) is True

    def test_empty_filter_matches_all(self) -> None:
        attrs = {"anything": {"DataType": "String", "StringValue": "value"}}
        assert matches_filter_policy(attrs, {}) is True

    def test_empty_attrs_with_no_filter(self) -> None:
        assert matches_filter_policy({}, None) is True
