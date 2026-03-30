"""Test client for cognito_lambda tests."""

from __future__ import annotations

from .constants import ROLE_ARN, TEST_FUNC, TEST_POOL


class CognitoLambdaTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _cognito = lws_session.client("cognito-idp")
        self._cognito = _cognito
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda

    def create_pool(self, name=TEST_POOL):
        resp = self._cognito.create_user_pool(PoolName=name)
        return resp["UserPool"]["Id"]

    def get_pool_id(self, name=TEST_POOL):
        resp = self._cognito.list_user_pools(MaxResults=60)
        for pool in resp.get("UserPools", []):
            if pool["Name"] == name:
                return pool["Id"]
        return None

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )

    def get_function_exists(self, name=TEST_FUNC):
        try:
            self._lambda.get_function(FunctionName=name)
            return True
        except Exception:
            return False
