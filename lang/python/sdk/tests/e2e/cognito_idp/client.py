"""Test client for cognito_idp tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import TEST_POOL_NAME


class CognitoIdpTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("cognito-idp")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def get_pool_id(self):
        return self._session.client("cognito-idp").list_user_pools(MaxResults=10)["UserPools"][0][
            "Id"
        ]

    def create_pool(self, name=TEST_POOL_NAME):
        try:
            resp = self._client.create_user_pool(PoolName=name)
            return resp["UserPool"]["Id"]
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "ResourceInUseException":
                pools = self._client.list_user_pools(MaxResults=10)["UserPools"]
                for pool in pools:
                    if pool["Name"] == name:
                        return pool["Id"]
            raise
