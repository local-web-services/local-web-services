"""Test client for apigateway_cognito tests."""

from __future__ import annotations

from .constants import TEST_API, TEST_POOL


class ApigatewayCognitoTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _apigateway = lws_session.client("apigateway")
        self._apigateway = _apigateway
        _cognito = lws_session.client("cognito-idp")
        self._cognito = _cognito

    def create_api(self, name=TEST_API):
        resp = self._apigateway.create_rest_api(name=name)
        return resp["id"]

    def get_api_id(self, name=TEST_API):
        resp = self._apigateway.get_rest_apis()
        for api in resp.get("items", []):
            if api["name"] == name:
                return api["id"]
        return None

    def create_pool(self, name=TEST_POOL):
        resp = self._cognito.create_user_pool(PoolName=name)
        return resp["UserPool"]["Id"]

    def get_pool_id(self, name=TEST_POOL):
        resp = self._cognito.list_user_pools(MaxResults=60)
        for pool in resp.get("UserPools", []):
            if pool["Name"] == name:
                return pool["Id"]
        return None
