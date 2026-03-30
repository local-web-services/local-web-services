"""Test client for opensearch tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import TEST_DOMAIN


class OpensearchTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("opensearch")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_domain(self, domain_name=TEST_DOMAIN):
        try:
            self._client.create_domain(DomainName=domain_name)
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "ResourceAlreadyExistsException":
                return
            raise
