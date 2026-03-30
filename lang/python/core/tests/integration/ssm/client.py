"""Test client for ssm tests."""

from __future__ import annotations

from .constants import _SSM_TARGET, INT_PARAM, INT_TAG_KEY, INT_TAG_VALUE, INT_VALUE


class SsmTestClient:
    def __init__(self, client):
        self._client = client

    def put_parameter(self, name: str = INT_PARAM) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_SSM_TARGET}.PutParameter"},
            json={"Name": name, "Value": INT_VALUE, "Type": "String"},
        )

    def add_tag(self) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_SSM_TARGET}.AddTagsToResource"},
            json={
                "ResourceType": "Parameter",
                "ResourceId": INT_PARAM,
                "Tags": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}],
            },
        )
