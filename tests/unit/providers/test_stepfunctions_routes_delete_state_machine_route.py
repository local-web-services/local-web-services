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


class TestDeleteStateMachineRoute:
    async def test_delete_existing(self, client: httpx.AsyncClient) -> None:
        await _request(
            client,
            "CreateStateMachine",
            {
                "name": "to-delete",
                "definition": '{"StartAt":"Pass","States":{"Pass":{"Type":"Pass","End":true}}}',
            },
        )
        resp = await _request(
            client,
            "DeleteStateMachine",
            {
                "stateMachineArn": "arn:aws:states:us-east-1:000000000000:stateMachine:to-delete",
            },
        )
        assert resp.status_code == 200

    async def test_delete_nonexistent(self, client: httpx.AsyncClient) -> None:
        resp = await _request(
            client,
            "DeleteStateMachine",
            {
                "stateMachineArn": "arn:aws:states:us-east-1:000000000000:stateMachine:nope",
            },
        )
        assert resp.status_code == 400
