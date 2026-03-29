"""Test client for lambda_sns tests."""

from __future__ import annotations

from .constants import ROLE_ARN, TEST_FUNC, TEST_TOPIC_NAME


class LambdaSnsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda
        _sns = lws_session.client("sns")
        self._sns = _sns

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )

    def create_topic(self, name=TEST_TOPIC_NAME):
        resp = self._sns.create_topic(Name=name)
        return resp["TopicArn"]
