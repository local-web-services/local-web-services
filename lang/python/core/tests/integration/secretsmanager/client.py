"""Test client for secretsmanager tests."""

from __future__ import annotations

from .constants import _SM_TARGET_PREFIX, INT_SECRET, INT_VALUE


class SecretsmanagerTestClient:
    def __init__(self, sync_client):
        self._client = sync_client

    def create_secret(self, name: str = INT_SECRET) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_SM_TARGET_PREFIX}.CreateSecret"},
            json={"Name": name, "SecretString": INT_VALUE},
        )

    def delete_secret(self, name: str = INT_SECRET) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_SM_TARGET_PREFIX}.DeleteSecret"},
            json={"SecretId": name},
        )

    def describe_secret(self, name: str = INT_SECRET) -> dict:
        r = self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_SM_TARGET_PREFIX}.DescribeSecret"},
            json={"SecretId": name},
        )
        if r.status_code == 200:
            return r.json()
        return {}
