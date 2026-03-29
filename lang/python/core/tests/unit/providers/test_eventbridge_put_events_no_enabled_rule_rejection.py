"""Tests for put_events routing validation — rejection when no enabled rules exist."""

from __future__ import annotations

import json

import httpx
import pytest

from lws.providers.eventbridge.provider import EventBridgeProvider, RuleConfig
from lws.providers.eventbridge.routes import create_eventbridge_app


async def _started_provider(rules: list[RuleConfig]) -> EventBridgeProvider:
    provider = EventBridgeProvider(rules=rules)
    await provider.start()
    return provider


def _client(app) -> httpx.AsyncClient:
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


class TestPutEventsNoEnabledRuleRejection:
    """put_events is rejected when no enabled rule targets the bus."""

    @pytest.mark.asyncio
    async def test_put_events_rejected_when_bus_has_no_enabled_rules(self) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_fragment = "No enabled rules"
        disabled_rule = RuleConfig(
            rule_name="disabled-rule",
            event_bus_name="default",
            event_pattern={"source": ["test.source"]},
            targets=[],
            enabled=False,
        )
        provider = await _started_provider(rules=[disabled_rule])
        app = create_eventbridge_app(provider)

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutEvents"},
                content=json.dumps(
                    {
                        "Entries": [
                            {
                                "Source": "test.source",
                                "DetailType": "TestEvent",
                                "Detail": json.dumps({}),
                            }
                        ]
                    }
                ),
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
    async def test_put_events_rejected_when_no_rules_exist_on_bus(self) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_fragment = "No enabled rules"
        provider = await _started_provider(rules=[])
        app = create_eventbridge_app(provider)

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutEvents"},
                content=json.dumps(
                    {
                        "Entries": [
                            {
                                "Source": "test.source",
                                "DetailType": "TestEvent",
                                "Detail": json.dumps({}),
                            }
                        ]
                    }
                ),
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
