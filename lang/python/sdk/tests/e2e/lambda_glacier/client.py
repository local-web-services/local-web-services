"""Test client for lambda_glacier tests."""

from __future__ import annotations

from .constants import ROLE_ARN, TEST_FUNC, TEST_VAULT


class LambdaGlacierTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda
        _glacier = lws_session.client("glacier")
        self._glacier = _glacier

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )

    def create_vault(self, name=TEST_VAULT):
        self._glacier.create_vault(accountId="-", vaultName=name)
