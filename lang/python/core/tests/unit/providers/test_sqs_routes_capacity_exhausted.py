"""Tests that SQS routes return OverLimit when capacity is exhausted."""

from __future__ import annotations

import httpx
import pytest

from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers.sqs.provider import QueueConfig, SqsProvider
from lws.providers.sqs.routes import create_sqs_app

_QUEUE_NAME = "test-queue"
_QUEUE_URL = f"http://localhost:4566/000000000000/{_QUEUE_NAME}"


def _make_provider() -> SqsProvider:
    """Return an SqsProvider with a single test queue."""
    provider = SqsProvider(queues=[QueueConfig(queue_name=_QUEUE_NAME)])
    return provider


class TestSqsRoutesCapacityExhausted:
    """SQS routes return OverLimit when capacity slots=0."""

    @pytest.mark.asyncio
    async def test_xml_send_message_capacity_exhausted(self) -> None:
        # Arrange
        provider = _make_provider()
        capacity = AwsCapacityConfig(slots=0)
        app = create_sqs_app(provider, capacity=capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        expected_status_code = 400
        expected_error_code = "OverLimit"

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            resp = await client.post(
                "/",
                data={"Action": "SendMessage", "QueueUrl": _QUEUE_URL, "MessageBody": "hello"},
            )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        actual_text = resp.text
        assert (
            expected_error_code in actual_text
        ), f"Expected {expected_error_code!r} to be in {actual_text!r}"

    @pytest.mark.asyncio
    async def test_xml_send_message_batch_capacity_exhausted(self) -> None:
        # Arrange
        provider = _make_provider()
        capacity = AwsCapacityConfig(slots=0)
        app = create_sqs_app(provider, capacity=capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        expected_status_code = 400
        expected_error_code = "OverLimit"

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            resp = await client.post(
                "/",
                data={
                    "Action": "SendMessageBatch",
                    "QueueUrl": _QUEUE_URL,
                    "SendMessageBatchRequestEntry.1.Id": "msg1",
                    "SendMessageBatchRequestEntry.1.MessageBody": "hello",
                },
            )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        actual_text = resp.text
        assert (
            expected_error_code in actual_text
        ), f"Expected {expected_error_code!r} to be in {actual_text!r}"

    @pytest.mark.asyncio
    async def test_json_send_message_capacity_exhausted(self) -> None:
        # Arrange
        provider = _make_provider()
        capacity = AwsCapacityConfig(slots=0)
        app = create_sqs_app(provider, capacity=capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        expected_status_code = 400
        expected_error_type = "OverLimit"

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            resp = await client.post(
                "/",
                json={"QueueUrl": _QUEUE_URL, "MessageBody": "hello"},
                headers={"x-amz-target": "AmazonSQS.SendMessage"},
            )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    @pytest.mark.asyncio
    async def test_json_send_message_batch_capacity_exhausted(self) -> None:
        # Arrange
        provider = _make_provider()
        capacity = AwsCapacityConfig(slots=0)
        app = create_sqs_app(provider, capacity=capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        expected_status_code = 400
        expected_error_type = "OverLimit"

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            resp = await client.post(
                "/",
                json={
                    "QueueUrl": _QUEUE_URL,
                    "Entries": [{"Id": "msg1", "MessageBody": "hello"}],
                },
                headers={"x-amz-target": "AmazonSQS.SendMessageBatch"},
            )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"
