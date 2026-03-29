"""Tests for put_events routing — rejection when SNS target topic is not ACTIVE."""

from __future__ import annotations

import json

import httpx
import pytest

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers.eventbridge.provider import EventBridgeProvider, RuleConfig, RuleTarget
from lws.providers.eventbridge.routes import create_eventbridge_app

_TOPIC_ARN = "arn:aws:sns:us-east-1:000000000000:my-topic"
_BUS_NAME = "default"
_RULE_NAME = "my-rule"


async def _started_provider() -> EventBridgeProvider:
    provider = EventBridgeProvider(
        rules=[
            RuleConfig(
                rule_name=_RULE_NAME,
                event_bus_name=_BUS_NAME,
                event_pattern={"source": ["test.source"]},
                targets=[RuleTarget(target_id="t1", arn=_TOPIC_ARN)],
                enabled=True,
            )
        ]
    )
    await provider.start()
    return provider


def _client(app) -> httpx.AsyncClient:
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


def _put_events_body() -> dict:
    return {
        "Entries": [
            {
                "EventBusName": _BUS_NAME,
                "Source": "test.source",
                "DetailType": "TestEvent",
                "Detail": json.dumps({}),
            }
        ]
    }


class TestPutEventsSnsTargetNotActive:
    """put_events is rejected when the SNS topic target is not ACTIVE."""

    @pytest.mark.asyncio
    async def test_put_events_rejected_when_sns_topic_is_creating(self) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_fragment = "not ACTIVE"
        lc = ResourceLifecycleConfig()
        sns_tracker = ResourceStateTracker(lc)
        sns_tracker.set_state("my-topic", "CREATING")
        provider = await _started_provider()
        app = create_eventbridge_app(provider, sns_tracker=sns_tracker)

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutEvents"},
                content=json.dumps(_put_events_body()),
            )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        actual_body = response.json()
        assert expected_error_fragment in actual_body.get(
            "Error", ""
        ), f"Expected {expected_error_fragment!r} to be in {actual_body!r}"

    @pytest.mark.asyncio
    async def test_put_events_rejected_when_sns_topic_is_deleting(self) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_fragment = "not ACTIVE"
        lc = ResourceLifecycleConfig()
        sns_tracker = ResourceStateTracker(lc)
        sns_tracker.set_state("my-topic", "DELETING")
        provider = await _started_provider()
        app = create_eventbridge_app(provider, sns_tracker=sns_tracker)

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutEvents"},
                content=json.dumps(_put_events_body()),
            )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        actual_body = response.json()
        assert expected_error_fragment in actual_body.get(
            "Error", ""
        ), f"Expected {expected_error_fragment!r} to be in {actual_body!r}"
