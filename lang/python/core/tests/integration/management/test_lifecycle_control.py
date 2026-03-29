"""Integration tests for the /_lws/control lifecycle control plane endpoints."""

from __future__ import annotations

import httpx
import pytest
from fastapi import FastAPI

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.lifecycle_control import create_lifecycle_control_router

_SVC = "dynamodb"
_TYPE = "table"
_RES = "test-table-1"


@pytest.fixture
def tracker():
    config = ResourceLifecycleConfig()
    return ResourceStateTracker(config)


@pytest.fixture
def app(tracker):
    # Arrange
    control_router = create_lifecycle_control_router({_SVC: {_TYPE: tracker}})
    fastapi_app = FastAPI()
    fastapi_app.include_router(control_router)
    return fastapi_app


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestForceLifecycleState:
    """PUT /_lws/control/{service}/{type}/{id}/lifecycle freezes resource in target state."""

    async def test_put_returns_200(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 200

        # Act
        actual_response = await client.put(
            f"/_lws/control/{_SVC}/{_TYPE}/{_RES}/lifecycle",
            json={"state": "CREATING"},
        )

        # Assert
        actual_status_code = actual_response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected status {expected_status_code} but got {actual_status_code}"

    async def test_put_forces_resource_into_target_state(
        self, client: httpx.AsyncClient, tracker: ResourceStateTracker
    ) -> None:
        # Arrange
        expected_state = "CREATING"

        # Act
        await client.put(
            f"/_lws/control/{_SVC}/{_TYPE}/{_RES}/lifecycle",
            json={"state": expected_state},
        )
        actual_state = tracker.get_state(_RES)

        # Assert
        assert (
            actual_state == expected_state
        ), f"Expected tracker state {expected_state!r} after PUT but got {actual_state!r}"

    async def test_put_freezes_resource_blocking_schedule_transition(
        self, client: httpx.AsyncClient, tracker: ResourceStateTracker
    ) -> None:
        # Arrange
        await client.put(
            f"/_lws/control/{_SVC}/{_TYPE}/{_RES}/lifecycle",
            json={"state": "CREATING"},
        )
        expected_state = "CREATING"

        # Act — schedule a synchronous transition that should be blocked by freeze
        tracker.schedule_transition(_RES, "ACTIVE", delay_ms=0)
        actual_state = tracker.get_state(_RES)

        # Assert
        assert actual_state == expected_state, (
            f"Expected frozen state {expected_state!r} to remain after schedule_transition "
            f"but got {actual_state!r}"
        )

    async def test_put_returns_404_for_unknown_service(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 404

        # Act
        actual_response = await client.put(
            "/_lws/control/unknown-svc/table/res-1/lifecycle",
            json={"state": "CREATING"},
        )

        # Assert
        actual_status_code = actual_response.status_code
        assert actual_status_code == expected_status_code, (
            f"Expected status {expected_status_code} for unknown service "
            f"but got {actual_status_code}"
        )

    async def test_put_returns_400_for_missing_state_field(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400

        # Act
        actual_response = await client.put(
            f"/_lws/control/{_SVC}/{_TYPE}/{_RES}/lifecycle",
            json={},
        )

        # Assert
        actual_status_code = actual_response.status_code
        assert actual_status_code == expected_status_code, (
            f"Expected status {expected_status_code} for missing state field "
            f"but got {actual_status_code}"
        )


class TestUnfreezeLifecycleState:
    """DELETE /_lws/control/{service}/{type}/{id}/lifecycle unfreezes resource."""

    async def test_delete_returns_200(self, client: httpx.AsyncClient) -> None:
        # Arrange
        await client.put(
            f"/_lws/control/{_SVC}/{_TYPE}/{_RES}/lifecycle",
            json={"state": "CREATING"},
        )
        expected_status_code = 200

        # Act
        actual_response = await client.delete(f"/_lws/control/{_SVC}/{_TYPE}/{_RES}/lifecycle")

        # Assert
        actual_status_code = actual_response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected status {expected_status_code} but got {actual_status_code}"

    async def test_delete_unfreezes_and_applies_pending_target(
        self, client: httpx.AsyncClient, tracker: ResourceStateTracker
    ) -> None:
        # Arrange
        await client.put(
            f"/_lws/control/{_SVC}/{_TYPE}/{_RES}/lifecycle",
            json={"state": "CREATING"},
        )
        tracker.schedule_transition(_RES, "ACTIVE", delay_ms=0)
        expected_state = "ACTIVE"

        # Act
        await client.delete(f"/_lws/control/{_SVC}/{_TYPE}/{_RES}/lifecycle")
        actual_state = tracker.get_state(_RES)

        # Assert
        assert actual_state == expected_state, (
            f"Expected state {expected_state!r} after unfreeze " f"but got {actual_state!r}"
        )

    async def test_delete_returns_404_for_unknown_service(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 404

        # Act
        actual_response = await client.delete("/_lws/control/unknown-svc/table/res-1/lifecycle")

        # Assert
        actual_status_code = actual_response.status_code
        assert actual_status_code == expected_status_code, (
            f"Expected status {expected_status_code} for unknown service "
            f"but got {actual_status_code}"
        )
