"""Tests for put_targets validation — rejection when Lambda function is missing or not ACTIVE."""

from __future__ import annotations

import json

import httpx
import pytest

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers.eventbridge.provider import EventBridgeProvider, RuleConfig
from lws.providers.eventbridge.routes import create_eventbridge_app
from lws.providers.lambda_runtime._lambda_registry import LambdaRegistry


async def _started_provider() -> EventBridgeProvider:
    provider = EventBridgeProvider(
        rules=[
            RuleConfig(
                rule_name="my-rule",
                event_bus_name="default",
                event_pattern={"source": ["test.source"]},
            )
        ]
    )
    await provider.start()
    return provider


def _client(app) -> httpx.AsyncClient:
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


def _put_targets_body(func_name: str) -> dict:
    return {
        "Rule": "my-rule",
        "Targets": [
            {
                "Id": "lambda-target",
                "Arn": f"arn:aws:lambda:us-east-1:000000000000:function:{func_name}",
            }
        ],
    }


class TestPutTargetsLambdaFunctionMissing:
    """put_targets is rejected when the Lambda function does not exist or is not ACTIVE."""

    @pytest.mark.asyncio
    async def test_put_targets_rejected_when_lambda_function_does_not_exist(self) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_fragment = "Lambda function does not exist"
        lambda_registry = LambdaRegistry()  # empty — no functions registered
        provider = await _started_provider()
        app = create_eventbridge_app(provider, lambda_registry=lambda_registry)

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutTargets"},
                content=json.dumps(_put_targets_body("nonexistent-func")),
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
    async def test_put_targets_rejected_when_lambda_function_is_not_active(self) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_fragment = "not ACTIVE"
        expected_func_name = "my-func"
        lambda_registry = LambdaRegistry()
        lambda_registry.register(expected_func_name, {"FunctionName": expected_func_name}, None)
        lc = ResourceLifecycleConfig()
        lambda_tracker = ResourceStateTracker(lc)
        lambda_tracker.set_state(expected_func_name, "CREATING")
        provider = await _started_provider()
        app = create_eventbridge_app(
            provider, lambda_registry=lambda_registry, lambda_tracker=lambda_tracker
        )

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutTargets"},
                content=json.dumps(_put_targets_body(expected_func_name)),
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
