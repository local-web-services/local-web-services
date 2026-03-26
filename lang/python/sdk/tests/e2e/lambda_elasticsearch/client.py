"""Test client for lambda_elasticsearch tests."""

from __future__ import annotations

from .constants import ROLE_ARN, TEST_DOMAIN, TEST_FUNC


class LambdaElasticsearchTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda
        _es = lws_session.client("es")
        self._es = _es

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )

    def create_domain(self, name=TEST_DOMAIN):
        self._es.create_elasticsearch_domain(DomainName=name)
