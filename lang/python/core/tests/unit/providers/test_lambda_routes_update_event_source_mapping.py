"""Tests for Lambda UpdateEventSourceMapping route."""

from __future__ import annotations

import pytest
from httpx import ASGITransport, AsyncClient

from lws.providers.lambda_runtime.routes import LambdaRegistry, create_lambda_management_app


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


class TestUpdateEventSourceMapping:
    """Tests for the UpdateEventSourceMapping route."""

    async def test_update_batch_size(self, client: AsyncClient) -> None:
        # Arrange
        create_body = {
            "EventSourceArn": "arn:aws:sqs:us-east-1:000000000000:update-queue",
            "FunctionName": "update-function",
            "BatchSize": 5,
        }
        create_resp = await client.post("/2015-03-31/event-source-mappings", json=create_body)
        esm_uuid = create_resp.json()["UUID"]
        expected_batch_size = 10

        # Act
        update_resp = await client.put(
            f"/2015-03-31/event-source-mappings/{esm_uuid}",
            json={"BatchSize": expected_batch_size},
        )

        # Assert
        expected_status = 200
        actual_status = update_resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_batch_size = update_resp.json()["BatchSize"]
        assert (
            actual_batch_size == expected_batch_size
        ), f"Expected {expected_batch_size!r} but got {actual_batch_size!r}"

    async def test_update_nonexistent_returns_404(self, client: AsyncClient) -> None:
        # Arrange
        expected_status = 404

        # Act
        resp = await client.put(
            "/2015-03-31/event-source-mappings/nonexistent-uuid",
            json={"BatchSize": 1},
        )

        # Assert
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
