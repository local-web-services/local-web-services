"""Tests for Lambda UntagResource operation."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.lambda_runtime.routes import (
    LambdaRegistry,
    create_lambda_management_app,
)

_FUNC_NAME = "my-func"
_FUNC_ARN = f"arn:aws:lambda:us-east-1:000000000000:function:{_FUNC_NAME}"


async def _create_function(client: httpx.AsyncClient) -> None:
    """Create a minimal Lambda function so tag operations can find it."""
    await client.post(
        "/2015-03-31/functions",
        json={
            "FunctionName": _FUNC_NAME,
            "Runtime": "python3.12",
            "Role": "arn:aws:iam::000000000000:role/test",
            "Handler": "index.handler",
            "Code": {"ZipFile": "UEsDBBQA"},
        },
    )


class TestUntagResource:
    """Tests for DELETE /2017-03-31/tags/{arn}?tagKeys=key1,key2."""

    @pytest.fixture
    def registry(self):
        # Arrange
        return LambdaRegistry()

    @pytest.fixture
    def client(self, registry):
        # Arrange
        app = create_lambda_management_app(registry)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    @pytest.mark.asyncio
    async def test_untag_resource(self, client) -> None:
        # Arrange
        await _create_function(client)
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod", "team": "backend", "version": "1.0"}},
        )
        expected_status = 204

        # Act
        resp = await client.delete(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            params={"tagKeys": "env,team"},
        )

        # Assert
        actual_status = resp.status_code
        assert actual_status == expected_status

        resp = await client.get(f"/2017-03-31/tags/{_FUNC_ARN}")
        data = resp.json()
        assert "env" not in data["Tags"]
        assert "team" not in data["Tags"]
        expected_version = "1.0"
        actual_version = data["Tags"]["version"]
        assert actual_version == expected_version

    @pytest.mark.asyncio
    async def test_untag_single_key(self, client) -> None:
        # Arrange
        await _create_function(client)
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod", "team": "backend"}},
        )
        expected_status = 204

        # Act
        resp = await client.delete(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            params={"tagKeys": "env"},
        )

        # Assert
        actual_status = resp.status_code
        assert actual_status == expected_status

        resp = await client.get(f"/2017-03-31/tags/{_FUNC_ARN}")
        data = resp.json()
        assert "env" not in data["Tags"]
        expected_team = "backend"
        actual_team = data["Tags"]["team"]
        assert actual_team == expected_team

    @pytest.mark.asyncio
    async def test_untag_nonexistent_key_is_noop(self, client) -> None:
        # Arrange
        await _create_function(client)
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod"}},
        )
        expected_status = 204
        expected_env_tag = "prod"

        # Act
        resp = await client.delete(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            params={"tagKeys": "nonexistent"},
        )

        # Assert
        actual_status = resp.status_code
        assert actual_status == expected_status

        resp = await client.get(f"/2017-03-31/tags/{_FUNC_ARN}")
        actual_env_tag = resp.json()["Tags"]["env"]
        assert actual_env_tag == expected_env_tag

    @pytest.mark.asyncio
    async def test_untag_via_2015_api_version(self, client) -> None:
        # Arrange
        await _create_function(client)
        await client.post(
            f"/2015-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod", "team": "backend"}},
        )
        expected_status = 204

        # Act
        resp = await client.delete(
            f"/2015-03-31/tags/{_FUNC_ARN}",
            params={"tagKeys": "env"},
        )

        # Assert
        actual_status = resp.status_code
        assert actual_status == expected_status

        resp = await client.get(f"/2015-03-31/tags/{_FUNC_ARN}")
        data = resp.json()
        assert "env" not in data["Tags"]
        expected_team = "backend"
        actual_team = data["Tags"]["team"]
        assert actual_team == expected_team
