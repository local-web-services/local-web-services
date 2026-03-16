"""Tests for Step Functions routes management operations."""

from __future__ import annotations

import json

import httpx
import pytest

from lws.providers.stepfunctions.provider import StepFunctionsProvider
from lws.providers.stepfunctions.routes import create_stepfunctions_app


@pytest.fixture()
async def client() -> httpx.AsyncClient:
    provider = StepFunctionsProvider()
    await provider.start()
    app = create_stepfunctions_app(provider)
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    client = httpx.AsyncClient(transport=transport, base_url="http://testserver")
    yield client
    await provider.stop()


async def _request(client: httpx.AsyncClient, target: str, body: dict) -> httpx.Response:
    return await client.post(
        "/",
        content=json.dumps(body),
        headers={"X-Amz-Target": f"AWSStepFunctions.{target}"},
    )


class TestCreateStateMachineRoute:
    async def test_create_returns_arn(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 200
        sm_name = "test-sm"

        # Act
        resp = await _request(
            client,
            "CreateStateMachine",
            {
                "name": sm_name,
                "definition": '{"StartAt":"Pass","States":{"Pass":{"Type":"Pass","End":true}}}',
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
        data = resp.json()
        assert "stateMachineArn" in data
        assert sm_name in data["stateMachineArn"]

    async def test_create_missing_name_returns_error(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400

        # Act
        resp = await _request(client, "CreateStateMachine", {"definition": "{}"})

        # Assert
        assert resp.status_code == expected_status_code
