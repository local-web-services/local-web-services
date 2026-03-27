"""Tests that Glacier routes return ServiceUnavailableException when capacity is exhausted."""

from __future__ import annotations

import httpx
import pytest

from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers.glacier.routes import create_glacier_app

_VAULT_NAME = "test-vault"


class TestGlacierRoutesCapacityExhausted:
    """Glacier routes return 503 ServiceUnavailableException when capacity slots=0."""

    @pytest.mark.asyncio
    async def test_upload_archive_capacity_exhausted(self) -> None:
        # Arrange
        capacity = AwsCapacityConfig(slots=0)
        app, _state = create_glacier_app(capacity=capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        expected_status_code = 503
        expected_error_type = "ServiceUnavailableException"

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            resp = await client.post(
                f"/-/vaults/{_VAULT_NAME}/archives",
                content=b"archive-body",
            )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    @pytest.mark.asyncio
    async def test_initiate_job_capacity_exhausted(self) -> None:
        # Arrange
        capacity = AwsCapacityConfig(slots=0)
        app, _state = create_glacier_app(capacity=capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        expected_status_code = 503
        expected_error_type = "ServiceUnavailableException"

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            resp = await client.post(
                f"/-/vaults/{_VAULT_NAME}/jobs",
                json={"Type": "inventory-retrieval"},
            )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"
