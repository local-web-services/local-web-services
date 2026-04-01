"""Test client for lambda_opensearch tests."""

from __future__ import annotations

from .constants import ROLE_ARN, TEST_DOMAIN, TEST_FUNC


class LambdaOpensearchTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda
        _opensearch = lws_session.client("opensearch")
        self._opensearch = _opensearch

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )

    def create_domain(self, name=TEST_DOMAIN):
        self._opensearch.create_domain(DomainName=name)
