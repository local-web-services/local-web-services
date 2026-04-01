"""Tests for delete_rule HTTP handler — rejection when rule has targets."""

from __future__ import annotations

import json

import httpx
import pytest

from lws.providers.eventbridge._eventbridge_state import RuleTarget
from lws.providers.eventbridge.provider import EventBridgeProvider
from lws.providers.eventbridge.routes import create_eventbridge_app


async def _provider_with_rule_and_target() -> EventBridgeProvider:
    provider = EventBridgeProvider()
    await provider.start()
    await provider.put_rule("rule-with-target", event_pattern={"source": ["test"]})
    await provider.put_targets(
        "rule-with-target",
        [RuleTarget(target_id="t1", arn="arn:aws:lambda:us-east-1:000000000000:function:f")],
    )
    return provider


def _client(app) -> httpx.AsyncClient:
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


class TestDeleteRuleWithTargets:
    @pytest.mark.asyncio
    async def test_delete_rule_with_targets_returns_validation_exception(self) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_type = "ValidationException"
        provider = await _provider_with_rule_and_target()
        app = create_eventbridge_app(provider)

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.DeleteRule"},
                content=json.dumps({"Name": "rule-with-target"}),
            )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        actual_body = response.json()
        actual_error_type = actual_body.get("__type", "")
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"
