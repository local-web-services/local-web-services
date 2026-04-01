"""Integration tests for CloudTrail wire-protocol trail lifecycle endpoints."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.cloudtrail.provider import CloudTrailProvider
from lws.providers.cloudtrail.routes import create_cloudtrail_app

_TARGET_BASE = "CloudTrail_20131101."


def _headers(action: str) -> dict:
    return {
        "x-amz-target": f"{_TARGET_BASE}{action}",
        "Content-Type": "application/x-amz-json-1.1",
    }


@pytest.fixture
def provider():
    return CloudTrailProvider()


@pytest.fixture
async def client(provider):
    app = create_cloudtrail_app(provider)
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestCloudTrailRoutesTrailLifecycle:
    """HTTP wire protocol for trail CRUD and logging state operations."""

    async def test_create_trail_returns_200(self, client) -> None:
        # Arrange
        body = {"Name": "my-trail", "S3BucketName": "my-bucket"}

        # Act
        actual = await client.post("/", headers=_headers("CreateTrail"), json=body)

        # Assert
        expected_status = 200
        assert actual.status_code == expected_status
        assert actual.json()["Name"] == "my-trail"

    async def test_create_trail_duplicate_returns_400(self, client) -> None:
        # Arrange
        body = {"Name": "dup-trail", "S3BucketName": "bucket"}
        await client.post("/", headers=_headers("CreateTrail"), json=body)

        # Act
        actual = await client.post("/", headers=_headers("CreateTrail"), json=body)

        # Assert
        expected_status = 400
        assert actual.status_code == expected_status
        assert "TrailAlreadyExistsException" in actual.json()["__type"]

    async def test_get_trail_returns_200(self, client) -> None:
        # Arrange
        await client.post(
            "/", headers=_headers("CreateTrail"), json={"Name": "t1", "S3BucketName": "b"}
        )

        # Act
        actual = await client.post("/", headers=_headers("GetTrail"), json={"Name": "t1"})

        # Assert
        expected_status = 200
        assert actual.status_code == expected_status
        assert actual.json()["Trail"]["Name"] == "t1"

    async def test_get_nonexistent_trail_returns_404(self, client) -> None:
        # Arrange
        # (no trail exists)

        # Act
        actual = await client.post("/", headers=_headers("GetTrail"), json={"Name": "no-trail"})

        # Assert
        expected_status = 404
        assert actual.status_code == expected_status

    async def test_list_trails(self, client) -> None:
        # Arrange
        await client.post(
            "/", headers=_headers("CreateTrail"), json={"Name": "t1", "S3BucketName": "b"}
        )
        await client.post(
            "/", headers=_headers("CreateTrail"), json={"Name": "t2", "S3BucketName": "b"}
        )

        # Act
        actual = await client.post("/", headers=_headers("ListTrails"), json={})

        # Assert
        expected_count = 2
        assert actual.status_code == 200
        assert len(actual.json()["Trails"]) == expected_count

    async def test_start_and_stop_logging(self, client) -> None:
        # Arrange
        await client.post(
            "/", headers=_headers("CreateTrail"), json={"Name": "t1", "S3BucketName": "b"}
        )

        # Act
        actual_start = await client.post("/", headers=_headers("StartLogging"), json={"Name": "t1"})
        status_after_start = await client.post(
            "/", headers=_headers("GetTrailStatus"), json={"Name": "t1"}
        )
        actual_stop = await client.post("/", headers=_headers("StopLogging"), json={"Name": "t1"})
        status_after_stop = await client.post(
            "/", headers=_headers("GetTrailStatus"), json={"Name": "t1"}
        )

        # Assert
        assert actual_start.status_code == 200
        assert status_after_start.json()["IsLogging"] is True
        assert actual_stop.status_code == 200
        assert status_after_stop.json()["IsLogging"] is False

    async def test_delete_trail(self, client) -> None:
        # Arrange
        await client.post(
            "/", headers=_headers("CreateTrail"), json={"Name": "t1", "S3BucketName": "b"}
        )

        # Act
        actual = await client.post("/", headers=_headers("DeleteTrail"), json={"Name": "t1"})
        get_after_delete = await client.post("/", headers=_headers("GetTrail"), json={"Name": "t1"})

        # Assert
        assert actual.status_code == 200
        expected_status = 404
        assert get_after_delete.status_code == expected_status
