"""Test client for elasticsearch tests."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError

from .constants import TEST_DOMAIN, TEST_INDEX


class ElasticsearchTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("es")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_domain(self, domain_name=TEST_DOMAIN):
        try:
            self._client.create_elasticsearch_domain(DomainName=domain_name)
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "ResourceAlreadyExistsException":
                return
            raise

    def create_index(self, domain_name=TEST_DOMAIN, index_name=TEST_INDEX):
        pytest.skip(
            "Cannot create an index without connecting to the Elasticsearch endpoint in lws"
        )
