"""Integration tests for the /_lws/control capacity control plane endpoints."""

from __future__ import annotations

import httpx
import pytest
from fastapi import FastAPI

from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers._shared.capacity_control import create_capacity_control_router

_SVC = "dynamodb"


@pytest.fixture
def config():
    # Arrange
    return AwsCapacityConfig()


@pytest.fixture
def app(config):
    # Arrange
    control_router = create_capacity_control_router({_SVC: config})
    fastapi_app = FastAPI()
    fastapi_app.include_router(control_router)
    return fastapi_app


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestPutCapacity:
    """PUT /_lws/control/{service}/capacity sets slots and exhausts capacity."""

    async def test_put_returns_200(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 200

        # Act
        actual_response = await client.put(
            f"/_lws/control/{_SVC}/capacity",
            json={"slots": 0},
        )

        # Assert
        actual_status_code = actual_response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected status {expected_status_code} but got {actual_status_code}"

    async def test_put_zero_exhausts_capacity(
        self, client: httpx.AsyncClient, config: AwsCapacityConfig
    ) -> None:
        # Arrange
        expected_exhausted = True

        # Act
        await client.put(f"/_lws/control/{_SVC}/capacity", json={"slots": 0})
        actual_exhausted = config.is_exhausted

        # Assert
        assert actual_exhausted == expected_exhausted, (
            f"Expected config.is_exhausted={expected_exhausted} after PUT slots=0 "
            f"but got {actual_exhausted}"
        )

    async def test_put_returns_404_for_unknown_service(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 404

        # Act
        actual_response = await client.put(
            "/_lws/control/unknown-svc/capacity",
            json={"slots": 0},
        )

        # Assert
        actual_status_code = actual_response.status_code
        assert actual_status_code == expected_status_code, (
            f"Expected status {expected_status_code} for unknown service "
            f"but got {actual_status_code}"
        )

    async def test_put_returns_400_for_missing_slots_field(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400

        # Act
        actual_response = await client.put(
            f"/_lws/control/{_SVC}/capacity",
            json={},
        )

        # Assert
        actual_status_code = actual_response.status_code
        assert actual_status_code == expected_status_code, (
            f"Expected status {expected_status_code} for missing slots field "
            f"but got {actual_status_code}"
        )


class TestDeleteCapacity:
    """DELETE /_lws/control/{service}/capacity resets capacity to unlimited."""

    async def test_delete_returns_200(self, client: httpx.AsyncClient) -> None:
        # Arrange
        await client.put(f"/_lws/control/{_SVC}/capacity", json={"slots": 0})
        expected_status_code = 200

        # Act
        actual_response = await client.delete(f"/_lws/control/{_SVC}/capacity")

        # Assert
        actual_status_code = actual_response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected status {expected_status_code} but got {actual_status_code}"

    async def test_delete_resets_to_unlimited(
        self, client: httpx.AsyncClient, config: AwsCapacityConfig
    ) -> None:
        # Arrange
        await client.put(f"/_lws/control/{_SVC}/capacity", json={"slots": 0})
        expected_slots = None

        # Act
        await client.delete(f"/_lws/control/{_SVC}/capacity")
        actual_slots = config.slots

        # Assert
        assert (
            actual_slots == expected_slots
        ), f"Expected slots={expected_slots} after DELETE but got {actual_slots}"

    async def test_delete_returns_404_for_unknown_service(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 404

        # Act
        actual_response = await client.delete("/_lws/control/unknown-svc/capacity")

        # Assert
        actual_status_code = actual_response.status_code
        assert actual_status_code == expected_status_code, (
            f"Expected status {expected_status_code} for unknown service "
            f"but got {actual_status_code}"
        )


class TestGetCapacity:
    """GET /_lws/control/{service}/capacity returns current config."""

    async def test_get_returns_200(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 200

        # Act
        actual_response = await client.get(f"/_lws/control/{_SVC}/capacity")

        # Assert
        actual_status_code = actual_response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected status {expected_status_code} but got {actual_status_code}"

    async def test_get_reflects_current_slots(self, client: httpx.AsyncClient) -> None:
        # Arrange
        await client.put(f"/_lws/control/{_SVC}/capacity", json={"slots": 0})
        expected_slots = 0

        # Act
        actual_response = await client.get(f"/_lws/control/{_SVC}/capacity")
        actual_slots = actual_response.json()["slots"]

        # Assert
        assert (
            actual_slots == expected_slots
        ), f"Expected slots={expected_slots} in GET response but got {actual_slots}"

    async def test_get_returns_404_for_unknown_service(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 404

        # Act
        actual_response = await client.get("/_lws/control/unknown-svc/capacity")

        # Assert
        actual_status_code = actual_response.status_code
        assert actual_status_code == expected_status_code, (
            f"Expected status {expected_status_code} for unknown service "
            f"but got {actual_status_code}"
        )
