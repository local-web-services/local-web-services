"""Tests for API Gateway stage throttle configuration storage."""

from __future__ import annotations

import httpx
import pytest
from httpx import ASGITransport

from lws.providers.apigateway.routes import create_apigateway_management_app


@pytest.fixture()
async def client():
    app = create_apigateway_management_app()[0]
    transport = ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://test") as c:
        yield c


async def _create_api_with_stage(
    client: httpx.AsyncClient,
    api_name: str = "throttle-api",
    stage_name: str = "prod",
    burst_limit: int | None = None,
) -> tuple[str, str]:
    """Create a REST API with a deployment and stage; return (api_id, stage_name)."""
    create_resp = await client.post("/restapis", json={"name": api_name})
    api_id = create_resp.json()["id"]
    deploy_resp = await client.post(f"/restapis/{api_id}/deployments", json={"description": "test"})
    deployment_id = deploy_resp.json()["id"]
    stage_body = {"stageName": stage_name, "deploymentId": deployment_id}
    if burst_limit is not None:
        stage_body["defaultRouteSettings"] = {"throttlingBurstLimit": burst_limit}
    await client.post(f"/restapis/{api_id}/stages", json=stage_body)
    return api_id, stage_name


class TestStageThrottleConfiguration:
    @pytest.mark.asyncio
    async def test_create_stage_stores_burst_limit(self, client: httpx.AsyncClient) -> None:
        # Arrange
        api_name = "throttle-config-api"
        stage_name = "prod"
        expected_burst_limit = 100
        create_resp = await client.post("/restapis", json={"name": api_name})
        api_id = create_resp.json()["id"]
        deploy_resp = await client.post(
            f"/restapis/{api_id}/deployments", json={"description": "test"}
        )
        deployment_id = deploy_resp.json()["id"]

        # Act
        stage_resp = await client.post(
            f"/restapis/{api_id}/stages",
            json={
                "stageName": stage_name,
                "deploymentId": deployment_id,
                "defaultRouteSettings": {"throttlingBurstLimit": expected_burst_limit},
            },
        )

        # Assert
        expected_status = 201
        actual_status = stage_resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_body = stage_resp.json()
        actual_burst_limit = actual_body.get("defaultRouteSettings", {}).get("throttlingBurstLimit")
        assert (
            actual_burst_limit == expected_burst_limit
        ), f"Expected {expected_burst_limit!r} but got {actual_burst_limit!r}"

    @pytest.mark.asyncio
    async def test_update_stage_sets_burst_limit(self, client: httpx.AsyncClient) -> None:
        # Arrange
        api_id, stage_name = await _create_api_with_stage(
            client, api_name="throttle-update-api", stage_name="dev"
        )
        expected_burst_limit = 50

        # Act
        update_resp = await client.patch(
            f"/restapis/{api_id}/stages/{stage_name}",
            json={
                "patchOperations": [
                    {
                        "op": "replace",
                        "path": "/defaultRouteSettings/throttlingBurstLimit",
                        "value": str(expected_burst_limit),
                    }
                ]
            },
        )

        # Assert
        expected_status = 200
        actual_status = update_resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_body = update_resp.json()
        actual_burst_limit = actual_body.get("defaultRouteSettings", {}).get("throttlingBurstLimit")
        assert (
            actual_burst_limit == expected_burst_limit
        ), f"Expected {expected_burst_limit!r} but got {actual_burst_limit!r}"

    @pytest.mark.asyncio
    async def test_get_stage_returns_throttle_config(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_burst_limit = 10
        api_id, stage_name = await _create_api_with_stage(
            client, api_name="throttle-get-api", stage_name="prod", burst_limit=expected_burst_limit
        )

        # Act
        get_resp = await client.get(f"/restapis/{api_id}/stages/{stage_name}")

        # Assert
        expected_status = 200
        actual_status = get_resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_body = get_resp.json()
        actual_burst_limit = actual_body.get("defaultRouteSettings", {}).get("throttlingBurstLimit")
        assert (
            actual_burst_limit == expected_burst_limit
        ), f"Expected {expected_burst_limit!r} but got {actual_burst_limit!r}"

    @pytest.mark.asyncio
    async def test_stage_without_throttle_has_none_burst_limit(
        self, client: httpx.AsyncClient
    ) -> None:
        # Arrange
        api_id, stage_name = await _create_api_with_stage(
            client, api_name="no-throttle-api", stage_name="staging"
        )

        # Act
        get_resp = await client.get(f"/restapis/{api_id}/stages/{stage_name}")

        # Assert
        expected_status = 200
        actual_status = get_resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_body = get_resp.json()
        actual_burst_limit = actual_body.get("defaultRouteSettings", {}).get("throttlingBurstLimit")
        expected_burst_limit = None
        assert (
            actual_burst_limit == expected_burst_limit
        ), f"Expected {expected_burst_limit!r} but got {actual_burst_limit!r}"
