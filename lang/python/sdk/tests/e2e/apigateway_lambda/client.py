"""Test client for apigateway_lambda tests."""

from __future__ import annotations

from .constants import ROLE_ARN, TEST_API, TEST_FUNC


class ApigatewayLambdaTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _apigateway = lws_session.client("apigateway")
        self._apigateway = _apigateway
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda

    def create_api(self, name=TEST_API):
        resp = self._apigateway.create_rest_api(name=name)
        return resp["id"]

    def get_api_id(self, name=TEST_API):
        resp = self._apigateway.get_rest_apis()
        for api in resp.get("items", []):
            if api["name"] == name:
                return api["id"]
        return None

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )
