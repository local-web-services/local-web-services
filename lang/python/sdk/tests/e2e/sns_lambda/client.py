"""Test client for sns_lambda tests."""

from __future__ import annotations

from .constants import ROLE_ARN, TEST_FUNC, TEST_TOPIC_NAME


class SnsLambdaTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sns = lws_session.client("sns")
        self._sns = _sns
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda

    def create_topic(self, name=TEST_TOPIC_NAME):
        self._sns.create_topic(Name=name)

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )
