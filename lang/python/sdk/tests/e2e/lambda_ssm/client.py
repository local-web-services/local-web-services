"""Test client for lambda_ssm tests."""

from __future__ import annotations

from .constants import ROLE_ARN, TEST_FUNC, TEST_PARAM, TEST_PARAM_VALUE


class LambdaSsmTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda
        _ssm = lws_session.client("ssm")
        self._ssm = _ssm

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )

    def create_param(self, name=TEST_PARAM):
        self._ssm.put_parameter(Name=name, Value=TEST_PARAM_VALUE, Type="String")
