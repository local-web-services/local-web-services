"""Test client for opensearch tests."""

from __future__ import annotations

from .constants import _OS_TARGET, INT_DOMAIN


class OpensearchTestClient:
    def __init__(self, client):
        self._client = client

    def post(self, action: str, body: dict):
        return self._client.post("/", headers={"X-Amz-Target": f"{_OS_TARGET}.{action}"}, json=body)

    def create_domain(self, domain_name: str = INT_DOMAIN) -> None:
        self.post("CreateDomain", {"DomainName": domain_name})

    def get_domain_arn(self, domain_name: str = INT_DOMAIN) -> str:
        r = self.post("DescribeDomain", {"DomainName": domain_name})
        return r.json().get("DomainStatus", {}).get("ARN", "")
