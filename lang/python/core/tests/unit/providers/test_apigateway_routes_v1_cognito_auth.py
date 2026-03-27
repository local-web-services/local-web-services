"""Tests for API Gateway V1 Cognito authorizer token validation."""

from __future__ import annotations

import json
from pathlib import Path
from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult
from lws.providers.apigateway.routes import create_apigateway_management_app
from lws.providers.cognito.authorizer import CognitoAuthorizer
from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.user_store import UserPoolConfig
from lws.providers.lambda_runtime.routes import LambdaRegistry

_POOL_ID = "us-east-1_testpool"
_LAMBDA_URI = (
    "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/"
    "arn:aws:lambda:us-east-1:000000000000:function:secure-func/invocations"
)


def _make_compute_fake(payload: dict | None = None) -> ICompute:
    fake = AsyncMock(spec=ICompute)
    fake.invoke.return_value = InvocationResult(
        payload=payload or {"statusCode": 200, "body": "{}"},
        error=None,
        duration_ms=1.0,
        request_id="req-id",
    )
    return fake


@pytest.fixture
async def cognito_setup(tmp_path: Path):
    """Provide a started CognitoProvider and its CognitoAuthorizer."""
    config = UserPoolConfig(user_pool_id=_POOL_ID, user_pool_name="test-pool")
    provider = CognitoProvider(data_dir=tmp_path, config=config)
    await provider.start()
    authorizer = CognitoAuthorizer(token_issuer=provider.token_issuer)
    yield provider, authorizer
    await provider.stop()


@pytest.fixture
def registry():
    return LambdaRegistry()


@pytest.fixture
def client(cognito_setup, registry):
    _, authorizer = cognito_setup
    app = create_apigateway_management_app(lambda_registry=registry, cognito_authorizer=authorizer)[
        0
    ]
    transport = httpx.ASGITransport(app=app)
    return httpx.AsyncClient(transport=transport, base_url="http://test")


async def _setup_api_with_cognito_auth(client, registry, cognito_provider):
    """Create REST API with COGNITO_USER_POOLS method authorizer."""
    fake_compute = _make_compute_fake(
        payload={"statusCode": 200, "body": json.dumps({"secured": True})}
    )
    registry.register("secure-func", {"FunctionName": "secure-func"}, fake_compute)

    api_resp = await client.post("/restapis", json={"name": "secure-api"})
    rest_api_id = api_resp.json()["id"]
    root_resource_id = api_resp.json()["rootResourceId"]

    # Create resource
    resource_resp = await client.post(
        f"/restapis/{rest_api_id}/resources/{root_resource_id}",
        json={"pathPart": "secure"},
    )
    resource_id = resource_resp.json()["id"]

    # Create authorizer
    authorizer_resp = await client.post(
        f"/restapis/{rest_api_id}/authorizers",
        json={
            "name": "cognito-auth",
            "type": "COGNITO_USER_POOLS",
            "providerARNs": [f"arn:aws:cognito-idp:us-east-1:000:userpool/{_POOL_ID}"],
        },
    )
    authorizer_id = authorizer_resp.json()["id"]

    # Create method with Cognito auth
    await client.put(
        f"/restapis/{rest_api_id}/resources/{resource_id}/methods/GET",
        json={"authorizationType": "COGNITO_USER_POOLS", "authorizerId": authorizer_id},
    )

    # Create Lambda integration
    await client.put(
        f"/restapis/{rest_api_id}/resources/{resource_id}/methods/GET/integration",
        json={"type": "AWS_PROXY", "httpMethod": "POST", "uri": _LAMBDA_URI},
    )

    # Deploy
    deployment_resp = await client.post(
        f"/restapis/{rest_api_id}/deployments", json={"description": "v1"}
    )
    deployment_id = deployment_resp.json()["id"]
    await client.post(
        f"/restapis/{rest_api_id}/stages",
        json={"stageName": "prod", "deploymentId": deployment_id},
    )

    return rest_api_id


async def _get_valid_token(provider: CognitoProvider) -> str:
    """Sign up, confirm, and authenticate a user; return the id_token."""
    await provider.store.sign_up("testuser", "Password123", {})
    await provider.store.confirm_sign_up("testuser")
    auth_result = await provider.initiate_auth("USER_PASSWORD_AUTH", "testuser", "Password123")
    return auth_result["AuthenticationResult"]["IdToken"]


class TestV1CognitoAuthorizer:
    """Test Cognito token validation on V1 proxy requests."""

    @pytest.mark.asyncio
    async def test_request_without_token_returns_401(self, client, registry, cognito_setup) -> None:
        # Arrange
        provider, _ = cognito_setup
        rest_api_id = await _setup_api_with_cognito_auth(client, registry, provider)

        # Act
        resp = await client.get(f"/{rest_api_id}/prod/secure")

        # Assert
        expected_status = 401
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"

    @pytest.mark.asyncio
    async def test_request_with_invalid_token_returns_401(
        self, client, registry, cognito_setup
    ) -> None:
        # Arrange
        provider, _ = cognito_setup
        rest_api_id = await _setup_api_with_cognito_auth(client, registry, provider)

        # Act
        resp = await client.get(
            f"/{rest_api_id}/prod/secure",
            headers={"Authorization": "Bearer invalid.token.value"},
        )

        # Assert
        expected_status = 401
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"

    @pytest.mark.asyncio
    async def test_request_with_valid_token_passes(self, client, registry, cognito_setup) -> None:
        # Arrange
        provider, _ = cognito_setup
        rest_api_id = await _setup_api_with_cognito_auth(client, registry, provider)
        token = await _get_valid_token(provider)

        # Act
        resp = await client.get(
            f"/{rest_api_id}/prod/secure",
            headers={"Authorization": f"Bearer {token}"},
        )

        # Assert
        expected_status = 200
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
