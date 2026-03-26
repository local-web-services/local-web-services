"""Test client for apigateway tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import (
    TEST_API_DESCRIPTION,
    TEST_API_NAME,
    TEST_AUTH_TYPE,
    TEST_HTTP_METHOD,
    TEST_INTEGRATION_TYPE,
    TEST_INTEGRATION_URI,
    TEST_STAGE_DEV,
    TEST_STAGE_PROD,
)


class ApigatewayTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("apigateway")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_rest_api(self, name=TEST_API_NAME):
        return self._client.create_rest_api(name=name, description=TEST_API_DESCRIPTION)

    def get_api_id(self):
        """Return the first REST API id found, or None."""
        resp = self._client.get_rest_apis()
        items = resp.get("items", [])
        return items[0]["id"] if items else None

    def get_root_resource_id(self, api_id):
        """Return the root resource id for *api_id*."""
        resp = self._client.get_resources(restApiId=api_id)
        for res in resp.get("items", []):
            if res.get("path") == "/":
                return res["id"]
        return None

    def get_or_create_api(self):
        """Return existing REST API id, or create one and return its id."""
        existing = self.get_api_id()
        if existing:
            return existing
        return self.create_rest_api()["id"]

    def setup_method(self):
        """Get-or-create API + root resource + GET method; return (api_id, resource_id).

        Idempotent: if the method already exists on the root resource, skip put_method.
        """
        api_id = self.get_or_create_api()
        resource_id = self.get_root_resource_id(api_id)
        try:
            self._client.put_method(
                restApiId=api_id,
                resourceId=resource_id,
                httpMethod=TEST_HTTP_METHOD,
                authorizationType=TEST_AUTH_TYPE,
            )
        except ClientError:
            pass
        return (api_id, resource_id)

    def setup_integration(self):
        """Get-or-create API + method + integration; return (api_id, resource_id)."""
        api_id, resource_id = self.setup_method()
        try:
            self._client.put_integration(
                restApiId=api_id,
                resourceId=resource_id,
                httpMethod=TEST_HTTP_METHOD,
                type=TEST_INTEGRATION_TYPE,
                uri=TEST_INTEGRATION_URI,
                integrationHttpMethod=TEST_HTTP_METHOD,
            )
        except ClientError:
            pass
        return (api_id, resource_id)

    def setup_deployment(self):
        """Get-or-create API + method + integration + deployment.

        Returns (api_id, resource_id, dep_id).
        """
        api_id, resource_id = self.setup_integration()
        existing_deps = self._client.get_deployments(restApiId=api_id)
        dep_items = existing_deps.get("items", [])
        if dep_items:
            dep_id = dep_items[0]["id"]
        else:
            dep = self._client.create_deployment(restApiId=api_id)
            dep_id = dep["id"]
        return (api_id, resource_id, dep_id)

    def setup_dev_stage(self):
        """Get-or-create API through to dev stage; return (api_id, resource_id, dep_id)."""
        api_id, resource_id, dep_id = self.setup_deployment()
        try:
            self._client.create_stage(
                restApiId=api_id, stageName=TEST_STAGE_DEV, deploymentId=dep_id
            )
        except ClientError:
            pass
        return (api_id, resource_id, dep_id)

    def setup_prod_stage(self):
        """Get-or-create API through to prod stage; return (api_id, resource_id, dep_id)."""
        api_id, resource_id, dep_id = self.setup_deployment()
        try:
            self._client.create_stage(
                restApiId=api_id, stageName=TEST_STAGE_PROD, deploymentId=dep_id
            )
        except ClientError:
            pass
        return (api_id, resource_id, dep_id)

    def get_stage_names(self, api_id):
        """Return list of stage names for *api_id*, or empty list if get_stages is unavailable."""
        try:
            stages = self._client.get_stages(restApiId=api_id)
            return [s.get("stageName") for s in stages.get("item", [])]
        except (ClientError, Exception):
            return []
