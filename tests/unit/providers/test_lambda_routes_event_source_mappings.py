"""Tests for Lambda event source mapping API operations."""

from __future__ import annotations

import pytest
from httpx import ASGITransport, AsyncClient

from lws.providers.lambda_runtime.routes import (
    LambdaRegistry,
    create_lambda_management_app,
)


@pytest.fixture
def app():
    """Create a Lambda management app."""
    registry = LambdaRegistry()
    return create_lambda_management_app(registry)


@pytest.fixture
async def client(app):
    """Create an async HTTP client for the app."""
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as c:
        yield c


class TestEventSourceMappings:
    """Event source mapping list, get, and delete operations."""

    async def test_list_returns_stored_mappings(self, client: AsyncClient) -> None:
        # Arrange
        create_body = {
            "EventSourceArn": "arn:aws:sqs:us-east-1:000000000000:my-queue",
            "FunctionName": "my-function",
            "BatchSize": 5,
        }
        create_resp = await client.post("/2015-03-31/event-source-mappings", json=create_body)
        expected_status = 202
        assert create_resp.status_code == expected_status
        esm_uuid = create_resp.json()["UUID"]

        # Act
        list_resp = await client.get("/2015-03-31/event-source-mappings")

        # Assert
        expected_list_status = 200
        assert list_resp.status_code == expected_list_status
        mappings = list_resp.json()["EventSourceMappings"]
        expected_count = 1
        actual_count = len(mappings)
        assert actual_count == expected_count
        actual_uuid = mappings[0]["UUID"]
        assert actual_uuid == esm_uuid

    async def test_get_returns_mapping_by_uuid(self, client: AsyncClient) -> None:
        # Arrange
        create_body = {
            "EventSourceArn": "arn:aws:sqs:us-east-1:000000000000:get-queue",
            "FunctionName": "get-function",
        }
        create_resp = await client.post("/2015-03-31/event-source-mappings", json=create_body)
        esm_uuid = create_resp.json()["UUID"]

        # Act
        get_resp = await client.get(f"/2015-03-31/event-source-mappings/{esm_uuid}")

        # Assert
        expected_status = 200
        assert get_resp.status_code == expected_status
        actual_uuid = get_resp.json()["UUID"]
        assert actual_uuid == esm_uuid

    async def test_delete_removes_mapping(self, client: AsyncClient) -> None:
        # Arrange
        create_body = {
            "EventSourceArn": "arn:aws:sqs:us-east-1:000000000000:del-queue",
            "FunctionName": "del-function",
        }
        create_resp = await client.post("/2015-03-31/event-source-mappings", json=create_body)
        esm_uuid = create_resp.json()["UUID"]

        # Act
        delete_resp = await client.delete(f"/2015-03-31/event-source-mappings/{esm_uuid}")

        # Assert
        expected_delete_status = 202
        assert delete_resp.status_code == expected_delete_status
        get_resp = await client.get(f"/2015-03-31/event-source-mappings/{esm_uuid}")
        expected_not_found = 404
        assert get_resp.status_code == expected_not_found

    async def test_get_nonexistent_returns_404(self, client: AsyncClient) -> None:
        # Act
        resp = await client.get("/2015-03-31/event-source-mappings/nonexistent-uuid")

        # Assert
        expected_status = 404
        assert resp.status_code == expected_status
