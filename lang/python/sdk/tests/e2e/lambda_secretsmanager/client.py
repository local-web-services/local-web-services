"""Test client for lambda_secretsmanager tests."""

from __future__ import annotations

from .constants import ROLE_ARN, TEST_FUNC, TEST_SECRET, TEST_SECRET_VALUE


class LambdaSecretsmanagerTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda
        _secretsmanager = lws_session.client("secretsmanager")
        self._secretsmanager = _secretsmanager

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )

    def create_secret(self, name=TEST_SECRET):
        self._secretsmanager.create_secret(Name=name, SecretString=TEST_SECRET_VALUE)
