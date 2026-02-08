"""Tests for the SNS provider (P1-17 through P1-21)."""

from __future__ import annotations

import asyncio
from unittest.mock import AsyncMock

import httpx
import pytest

from ldk.interfaces import ICompute, InvocationResult
from ldk.interfaces.queue import IQueue
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


class TestFanOut:
    """Test fan-out to multiple subscribers."""

    @pytest.mark.asyncio
    async def test_fan_out_to_multiple_subscribers(self) -> None:
        provider = await _started_provider()
        compute_a = _make_compute_mock(payload={"statusCode": 200})
        compute_b = _make_compute_mock(payload={"statusCode": 200})
        mock_queue = _make_queue_mock()
        provider.set_compute_providers({"func-a": compute_a, "func-b": compute_b})
        provider.set_queue_provider(mock_queue)

        await provider.subscribe(topic_name="my-topic", protocol="lambda", endpoint="func-a")
        await provider.subscribe(topic_name="my-topic", protocol="lambda", endpoint="func-b")
        await provider.subscribe(
            topic_name="my-topic",
            protocol="sqs",
            endpoint="arn:aws:sqs:us-east-1:000000000000:q1",
        )

        await provider.publish(topic_name="my-topic", message="fan-out test")
        await asyncio.sleep(0.05)

        compute_a.invoke.assert_called_once()
        compute_b.invoke.assert_called_once()
        mock_queue.send_message.assert_called_once()

    @pytest.mark.asyncio
    async def test_fan_out_respects_filter_policy(self) -> None:
        provider = await _started_provider()
        compute_match = _make_compute_mock(payload={"statusCode": 200})
        compute_no_match = _make_compute_mock(payload={"statusCode": 200})
        provider.set_compute_providers(
            {
                "match-func": compute_match,
                "no-match-func": compute_no_match,
            }
        )

        await provider.subscribe(
            topic_name="my-topic",
            protocol="lambda",
            endpoint="match-func",
            filter_policy={"color": ["red"]},
        )
        await provider.subscribe(
            topic_name="my-topic",
            protocol="lambda",
            endpoint="no-match-func",
            filter_policy={"color": ["blue"]},
        )

        await provider.publish(
            topic_name="my-topic",
            message="filtered message",
            message_attributes={
                "color": {"DataType": "String", "StringValue": "red"},
            },
        )
        await asyncio.sleep(0.05)

        compute_match.invoke.assert_called_once()
        compute_no_match.invoke.assert_not_called()
