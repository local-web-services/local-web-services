"""Tests that SNS routes return a capacity error when capacity is exhausted."""

from __future__ import annotations

import httpx
import pytest

from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers.sns.provider import SnsProvider, TopicConfig
from lws.providers.sns.routes import create_sns_app

_TOPIC_ARN = "arn:aws:sns:us-east-1:000000000000:my-topic"
_EXPECTED_ERROR_CODE = "KMSThrottlingException"


async def _started_provider() -> SnsProvider:
    """Return a started SnsProvider with a single test topic."""
    provider = SnsProvider(topics=[TopicConfig(topic_name="my-topic", topic_arn=_TOPIC_ARN)])
    await provider.start()
    return provider


class TestSnsRoutesCapacityExhausted:
    """SNS routes return capacity error when sns_capacity slots=0."""

    @pytest.mark.asyncio
    async def test_publish_sns_capacity_exhausted(self) -> None:
        # Arrange
        provider = await _started_provider()
        sns_capacity = AwsCapacityConfig(slots=0)
        app = create_sns_app(provider, sns_capacity=sns_capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        expected_status_code = 400
        expected_error_code = _EXPECTED_ERROR_CODE

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            resp = await client.post(
                "/",
                data={
                    "Action": "Publish",
                    "TopicArn": _TOPIC_ARN,
                    "Message": "hello",
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
    async def test_subscribe_sns_capacity_exhausted(self) -> None:
        # Arrange
        provider = await _started_provider()
        sns_capacity = AwsCapacityConfig(slots=0)
        app = create_sns_app(provider, sns_capacity=sns_capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        expected_status_code = 400
        expected_error_code = _EXPECTED_ERROR_CODE

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            resp = await client.post(
                "/",
                data={
                    "Action": "Subscribe",
                    "TopicArn": _TOPIC_ARN,
                    "Protocol": "lambda",
                    "Endpoint": "my-func",
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
