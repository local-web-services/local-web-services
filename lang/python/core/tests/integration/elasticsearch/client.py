"""Test client for elasticsearch tests."""

from __future__ import annotations

from .constants import _ES_TARGET, INT_DOMAIN


class ElasticsearchTestClient:
    def __init__(self, client):
        self._client = client

    def post(self, action: str, body: dict):
        return self._client.post("/", headers={"X-Amz-Target": f"{_ES_TARGET}.{action}"}, json=body)

    def create_domain(self, domain_name: str = INT_DOMAIN) -> None:
        self.post("CreateElasticsearchDomain", {"DomainName": domain_name})

    def get_domain_arn(self, domain_name: str = INT_DOMAIN) -> str:
        r = self.post("DescribeElasticsearchDomain", {"DomainName": domain_name})
        return r.json().get("DomainStatus", {}).get("ARN", "")
