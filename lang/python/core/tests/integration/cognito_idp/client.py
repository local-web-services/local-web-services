"""Test client for cognito_idp tests."""

from __future__ import annotations

from starlette.testclient import TestClient

from .constants import _COGNITO_TARGET, INT_POOL_ID, INT_USERNAME


class CognitoIdpTestClient:
    def __init__(self, client):
        self._client = client

    def cognito_post(self, operation: str, body: dict) -> TestClient:
        return self._client.post(
            "/",
            headers={
                "X-Amz-Target": f"{_COGNITO_TARGET}.{operation}",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json=body,
        )

    def create_user(self, username: str = INT_USERNAME, pool_id: str = INT_POOL_ID) -> None:
        self.cognito_post("AdminCreateUser", {"UserPoolId": pool_id, "Username": username})
