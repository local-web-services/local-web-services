"""Tests for Step Functions Activity operations."""

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


class TestActivityOperations:
    async def test_create_activity_returns_arn(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_name = "my-activity"
        expected_status_code = 200
        expected_arn_fragment = "activity:my-activity"

        # Act
        resp = await _request(client, "CreateActivity", {"name": expected_name})

        # Assert
        assert resp.status_code == expected_status_code, (
            f"Expected {expected_status_code!r} but got {resp.status_code!r}"
        )
        actual_arn = resp.json()["activityArn"]
        assert expected_arn_fragment in actual_arn, (
            f"Expected {expected_arn_fragment!r} to be in {actual_arn!r}"
        )

    async def test_list_activities_returns_created_activity(
        self, client: httpx.AsyncClient
    ) -> None:
        # Arrange
        expected_name = "list-me-activity"
        await _request(client, "CreateActivity", {"name": expected_name})

        # Act
        resp = await _request(client, "ListActivities", {})

        # Assert
        actual_activities = resp.json().get("activities", [])
        actual_names = [a["name"] for a in actual_activities]
        assert expected_name in actual_names, (
            f"Expected {expected_name!r} to be in {actual_names!r}"
        )

    async def test_describe_activity_returns_record(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_name = "describe-me"
        create_resp = await _request(client, "CreateActivity", {"name": expected_name})
        expected_arn = create_resp.json()["activityArn"]

        # Act
        resp = await _request(client, "DescribeActivity", {"activityArn": expected_arn})

        # Assert
        actual_name = resp.json()["name"]
        assert actual_name == expected_name, (
            f"Expected {expected_name!r} but got {actual_name!r}"
        )

    async def test_delete_activity_removes_it(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_name = "delete-me"
        expected_error_type = "ActivityDoesNotExist"
        create_resp = await _request(client, "CreateActivity", {"name": expected_name})
        activity_arn = create_resp.json()["activityArn"]

        # Act
        await _request(client, "DeleteActivity", {"activityArn": activity_arn})
        describe_resp = await _request(client, "DescribeActivity", {"activityArn": activity_arn})

        # Assert
        actual_error_type = describe_resp.json().get("__type", "")
        assert actual_error_type == expected_error_type, (
            f"Expected {expected_error_type!r} but got {actual_error_type!r}"
        )
