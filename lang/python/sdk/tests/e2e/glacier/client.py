"""Test client for glacier tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import TEST_VAULT


class GlacierTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("glacier")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_vault(self, vault_name=TEST_VAULT):
        try:
            self._client.create_vault(accountId="-", vaultName=vault_name)
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "ResourceInUseException":
                return
            raise

    def upload_archive(self, vault_name=TEST_VAULT):
        return self._client.upload_archive(
            accountId="-", vaultName=vault_name, body=b"e2e-test-archive-data"
        )
