"""Tests for Lambda TagResource operation."""

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


class TestTagResource:
    """Tests for POST /2017-03-31/tags/{arn}."""

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
    async def test_tag_resource(self, client) -> None:
        # Arrange
        await _create_function(client)
        expected_status = 204

        # Act
        resp = await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod", "team": "backend"}},
        )

        # Assert
        actual_status = resp.status_code
        assert actual_status == expected_status

    @pytest.mark.asyncio
    async def test_tags_are_returned_by_list_tags(self, client) -> None:
        # Arrange
        await _create_function(client)
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod", "team": "backend"}},
        )
        expected_env_tag = "prod"
        expected_team_tag = "backend"

        # Act
        resp = await client.get(f"/2017-03-31/tags/{_FUNC_ARN}")

        # Assert
        expected_status = 200
        actual_status = resp.status_code
        assert actual_status == expected_status
        data = resp.json()
        actual_env_tag = data["Tags"]["env"]
        assert actual_env_tag == expected_env_tag
        actual_team_tag = data["Tags"]["team"]
        assert actual_team_tag == expected_team_tag

    @pytest.mark.asyncio
    async def test_tag_resource_merges_tags(self, client) -> None:
        # Arrange
        await _create_function(client)
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod"}},
        )
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"team": "backend"}},
        )
        expected_env_tag = "prod"
        expected_team_tag = "backend"

        # Act
        resp = await client.get(f"/2017-03-31/tags/{_FUNC_ARN}")

        # Assert
        expected_status = 200
        actual_status = resp.status_code
        assert actual_status == expected_status
        data = resp.json()
        actual_env_tag = data["Tags"]["env"]
        assert actual_env_tag == expected_env_tag
        actual_team_tag = data["Tags"]["team"]
        assert actual_team_tag == expected_team_tag

    @pytest.mark.asyncio
    async def test_tag_resource_overwrites_existing_key(self, client) -> None:
        # Arrange
        await _create_function(client)
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "dev"}},
        )
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod"}},
        )
        expected_env_tag = "prod"

        # Act
        resp = await client.get(f"/2017-03-31/tags/{_FUNC_ARN}")

        # Assert
        expected_status = 200
        actual_status = resp.status_code
        assert actual_status == expected_status
        actual_env_tag = resp.json()["Tags"]["env"]
        assert actual_env_tag == expected_env_tag

    @pytest.mark.asyncio
    async def test_tag_resource_via_2015_api_version(self, client) -> None:
        # Arrange
        await _create_function(client)
        expected_env_tag = "staging"

        # Act
        resp = await client.post(
            f"/2015-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "staging"}},
        )

        # Assert
        expected_post_status = 204
        actual_post_status = resp.status_code
        assert actual_post_status == expected_post_status

        resp = await client.get(f"/2015-03-31/tags/{_FUNC_ARN}")
        expected_get_status = 200
        actual_get_status = resp.status_code
        assert actual_get_status == expected_get_status
        actual_env_tag = resp.json()["Tags"]["env"]
        assert actual_env_tag == expected_env_tag

    @pytest.mark.asyncio
    async def test_tags_stored_in_registry(self, client, registry) -> None:
        # Arrange
        await _create_function(client)
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod"}},
        )
        expected_tags = {"env": "prod"}

        # Act
        actual_tags = registry.get_tags(_FUNC_ARN)

        # Assert
        assert actual_tags == expected_tags
