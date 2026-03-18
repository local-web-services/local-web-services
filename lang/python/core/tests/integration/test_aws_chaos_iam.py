"""Integration tests for AWS chaos injection on IAM (IAM XML format)."""

from __future__ import annotations

import httpx
import pytest

from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsErrorSpec
from lws.providers.iam.routes import create_iam_app


class TestIamChaosXmlFormat:
    """Verify chaos middleware injects IAM-style XML error responses."""

    @pytest.fixture
    def chaos_config(self):
        """Create a chaos config that always injects errors."""
        return AwsChaosConfig(
            enabled=True,
            error_rate=1.0,
            errors=[
                AwsErrorSpec(
                    type="NoSuchEntity",
                    message="Entity does not exist.",
                    weight=1.0,
                )
            ],
        )

    @pytest.fixture
    def app(self, chaos_config):
        """Create IAM app with chaos enabled."""
        return create_iam_app(chaos=chaos_config)

    @pytest.fixture
    async def client(self, app):
        """Create async HTTP client."""
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_chaos_injects_iam_xml_error(self, client: httpx.AsyncClient):
        """Verify chaos injects a properly formatted IAM ErrorResponse XML."""
        # Arrange
        expected_status = 404
        expected_code = "NoSuchEntity"

        # Act
        response = await client.post(
            "/",
            data={"Action": "ListRoles"},
        )

        # Assert
        assert response.status_code == expected_status
        body = response.text
        assert "<ErrorResponse>" in body
        assert f"<Code>{expected_code}</Code>" in body
        assert "<Message>Entity does not exist.</Message>" in body

    async def test_chaos_disabled_passes_through(self, chaos_config):
        """Verify IAM requests pass through when chaos is disabled."""
        # Arrange
        chaos_config.enabled = False
        app = create_iam_app(chaos=chaos_config)
        transport = httpx.ASGITransport(app=app)
        expected_status = 200

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            response = await c.post(
                "/",
                data={"Action": "ListRoles"},
            )

        # Assert
        assert response.status_code == expected_status
