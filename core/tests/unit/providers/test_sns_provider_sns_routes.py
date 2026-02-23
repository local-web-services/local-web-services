"""Tests for the SNS provider (P1-17 through P1-21)."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult
from lws.interfaces.queue import IQueue
from lws.providers.sns.provider import (
    SnsProvider,
    TopicConfig,
)
from lws.providers.sns.routes import create_sns_app

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


class TestSnsRoutes:
    """Test SNS HTTP wire protocol routes."""

    @pytest.mark.asyncio
    async def test_publish_action(self) -> None:
        # Arrange
        provider = await _started_provider()
        app = create_sns_app(provider)
        expected_status = 200

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                data={
                    "Action": "Publish",
                    "TopicArn": "arn:aws:sns:us-east-1:000000000000:my-topic",
                    "Message": "wire protocol test",
                },
            )

        # Assert
        assert response.status_code == expected_status
        assert "<MessageId>" in response.text
        assert "</PublishResponse>" in response.text

    @pytest.mark.asyncio
    async def test_subscribe_action(self) -> None:
        # Arrange
        provider = await _started_provider()
        app = create_sns_app(provider)
        expected_status = 200

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                data={
                    "Action": "Subscribe",
                    "TopicArn": "arn:aws:sns:us-east-1:000000000000:my-topic",
                    "Protocol": "lambda",
                    "Endpoint": "my-func",
                },
            )

        # Assert
        assert response.status_code == expected_status
        assert "<SubscriptionArn>" in response.text
        assert "</SubscribeResponse>" in response.text

    @pytest.mark.asyncio
    async def test_list_topics_action(self) -> None:
        # Arrange
        provider = await _started_provider()
        app = create_sns_app(provider)
        expected_status = 200

        # Act
        async with _client(app) as client:
            response = await client.post("/", data={"Action": "ListTopics"})

        # Assert
        assert response.status_code == expected_status
        assert "<ListTopicsResponse>" in response.text
        assert "my-topic" in response.text
        assert "other-topic" in response.text

    @pytest.mark.asyncio
    async def test_list_subscriptions_action(self) -> None:
        # Arrange
        provider = await _started_provider()
        await provider.subscribe(
            topic_name="my-topic",
            protocol="lambda",
            endpoint="func-a",
        )
        app = create_sns_app(provider)
        expected_status = 200

        # Act
        async with _client(app) as client:
            response = await client.post("/", data={"Action": "ListSubscriptions"})

        # Assert
        assert response.status_code == expected_status
        assert "<ListSubscriptionsResponse>" in response.text
        assert "func-a" in response.text

    @pytest.mark.asyncio
    async def test_create_topic_action(self) -> None:
        # Arrange
        provider = await _started_provider()
        app = create_sns_app(provider)
        expected_status = 200

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                data={"Action": "CreateTopic", "Name": "my-topic"},
            )

        # Assert
        assert response.status_code == expected_status
        assert "<TopicArn>" in response.text
        assert "my-topic" in response.text

    @pytest.mark.asyncio
    async def test_unknown_action_returns_error(self) -> None:
        # Arrange
        provider = await _started_provider()
        app = create_sns_app(provider)
        expected_status = 400

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                data={"Action": "Bogus"},
            )

        # Assert
        assert response.status_code == expected_status
        assert "<ErrorResponse>" in response.text
        assert "<Code>InvalidAction</Code>" in response.text
        assert "lws" in response.text
        assert "SNS" in response.text
        assert "Bogus" in response.text

    @pytest.mark.asyncio
    async def test_publish_with_message_attributes(self) -> None:
        # Arrange
        provider = await _started_provider()
        app = create_sns_app(provider)
        expected_status = 200

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                data={
                    "Action": "Publish",
                    "TopicArn": "arn:aws:sns:us-east-1:000000000000:my-topic",
                    "Message": "attr test",
                    "MessageAttributes.entry.1.Name": "color",
                    "MessageAttributes.entry.1.Value.DataType": "String",
                    "MessageAttributes.entry.1.Value.StringValue": "red",
                },
            )

        # Assert
        assert response.status_code == expected_status
        assert "<MessageId>" in response.text
