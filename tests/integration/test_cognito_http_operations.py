"""Integration tests for the Cognito HTTP wire protocol."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.routes import create_cognito_app
from lws.providers.cognito.user_store import UserPoolConfig


@pytest.fixture
async def provider(tmp_path: Path):
    p = CognitoProvider(
        data_dir=tmp_path,
        config=UserPoolConfig(
            user_pool_id="us-east-1_TestPool",
            auto_confirm=True,
            client_id="test-client",
        ),
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_cognito_app(provider)


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestCognitoHttpOperations:
    async def test_sign_up(self, client: httpx.AsyncClient):
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.SignUp",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "ClientId": "test-client",
                "Username": "testuser",
                "Password": "Password1!",
                "UserAttributes": [
                    {"Name": "email", "Value": "test@example.com"},
                ],
            },
        )
        assert resp.status_code == 200
        body = resp.json()
        assert body["UserConfirmed"] is True
        assert "UserSub" in body

    async def test_initiate_auth(self, client: httpx.AsyncClient):
        await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.SignUp",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "ClientId": "test-client",
                "Username": "authuser",
                "Password": "Password1!",
            },
        )

        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.InitiateAuth",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "AuthFlow": "USER_PASSWORD_AUTH",
                "ClientId": "test-client",
                "AuthParameters": {
                    "USERNAME": "authuser",
                    "PASSWORD": "Password1!",
                },
            },
        )
        assert resp.status_code == 200
        body = resp.json()
        auth_result = body["AuthenticationResult"]
        assert "IdToken" in auth_result
        assert "AccessToken" in auth_result
        assert "RefreshToken" in auth_result

    async def test_get_user(self, client: httpx.AsyncClient):
        await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.SignUp",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "ClientId": "test-client",
                "Username": "getuser",
                "Password": "Password1!",
            },
        )

        auth_resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.InitiateAuth",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "AuthFlow": "USER_PASSWORD_AUTH",
                "ClientId": "test-client",
                "AuthParameters": {
                    "USERNAME": "getuser",
                    "PASSWORD": "Password1!",
                },
            },
        )
        assert auth_resp.status_code == 200
        access_token = auth_resp.json()["AuthenticationResult"]["AccessToken"]
        assert access_token is not None

    async def test_jwks_endpoint(self, client: httpx.AsyncClient):
        resp = await client.get("/.well-known/jwks.json")
        assert resp.status_code == 200
        body = resp.json()
        assert "keys" in body
        assert len(body["keys"]) > 0
