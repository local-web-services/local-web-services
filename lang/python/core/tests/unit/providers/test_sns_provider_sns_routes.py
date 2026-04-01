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


def _make_compute_fake(payload: dict | None = None, error: str | None = None) -> ICompute:
    """Return a fake ICompute whose ``invoke`` resolves to the given result."""
    fake = AsyncMock(spec=ICompute)
    fake.invoke.return_value = InvocationResult(
        payload=payload,
        error=error,
        duration_ms=1.0,
        request_id="test-request-id",
    )
    return fake


def _make_queue_fake() -> IQueue:
    """Return a fake IQueue."""
    fake = AsyncMock(spec=IQueue)
    fake.send_message.return_value = "fake-sqs-message-id"
    return fake


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
        await provider.subscribe(topic_name="my-topic", protocol="lambda", endpoint="my-func")
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
        assert (
            response.status_code == expected_status
        ), f"Expected {expected_status!r} but got {response.status_code!r}"
        assert (
            "<MessageId>" in response.text
        ), f'Expected {"<MessageId>"!r} to be in {response.text!r}'
        assert (
            "</PublishResponse>" in response.text
        ), f'Expected {"</PublishResponse>"!r} to be in {response.text!r}'

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
        assert (
            response.status_code == expected_status
        ), f"Expected {expected_status!r} but got {response.status_code!r}"
        assert (
            "<SubscriptionArn>" in response.text
        ), f'Expected {"<SubscriptionArn>"!r} to be in {response.text!r}'
        assert (
            "</SubscribeResponse>" in response.text
        ), f'Expected {"</SubscribeResponse>"!r} to be in {response.text!r}'

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
        assert (
            response.status_code == expected_status
        ), f"Expected {expected_status!r} but got {response.status_code!r}"
        assert (
            "<ListTopicsResponse>" in response.text
        ), f'Expected {"<ListTopicsResponse>"!r} to be in {response.text!r}'
        assert "my-topic" in response.text, f'Expected {"my-topic"!r} to be in {response.text!r}'
        assert (
            "other-topic" in response.text
        ), f'Expected {"other-topic"!r} to be in {response.text!r}'

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
        assert (
            response.status_code == expected_status
        ), f"Expected {expected_status!r} but got {response.status_code!r}"
        assert (
            "<ListSubscriptionsResponse>" in response.text
        ), f'Expected {"<ListSubscriptionsResponse>"!r} to be in {response.text!r}'
        assert "func-a" in response.text, f'Expected {"func-a"!r} to be in {response.text!r}'

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
                data={"Action": "CreateTopic", "Name": "new-topic"},
            )

        # Assert
        assert (
            response.status_code == expected_status
        ), f"Expected {expected_status!r} but got {response.status_code!r}"
        assert (
            "<TopicArn>" in response.text
        ), f'Expected {"<TopicArn>"!r} to be in {response.text!r}'
        assert "new-topic" in response.text, f'Expected {"new-topic"!r} to be in {response.text!r}'

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
        assert (
            response.status_code == expected_status
        ), f"Expected {expected_status!r} but got {response.status_code!r}"
        assert (
            "<ErrorResponse>" in response.text
        ), f'Expected {"<ErrorResponse>"!r} to be in {response.text!r}'
        assert (
            "<Code>InvalidAction</Code>" in response.text
        ), f'Expected {"<Code>InvalidAction</Code>"!r} to be in {response.text!r}'
        assert "lws" in response.text, f'Expected {"lws"!r} to be in {response.text!r}'
        assert "SNS" in response.text, f'Expected {"SNS"!r} to be in {response.text!r}'
        assert "Bogus" in response.text, f'Expected {"Bogus"!r} to be in {response.text!r}'

    @pytest.mark.asyncio
    async def test_publish_with_message_attributes(self) -> None:
        # Arrange
        provider = await _started_provider()
        await provider.subscribe(topic_name="my-topic", protocol="lambda", endpoint="my-func")
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
        assert (
            response.status_code == expected_status
        ), f"Expected {expected_status!r} but got {response.status_code!r}"
        assert (
            "<MessageId>" in response.text
        ), f'Expected {"<MessageId>"!r} to be in {response.text!r}'
