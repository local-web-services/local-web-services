"""Test client for apigateway tests."""

from __future__ import annotations

from .constants import INT_API_NAME, INT_HTTP_METHOD, INT_INTEGRATION_TYPE, INT_RESOURCE_PATH


class ApigatewayTestClient:
    def __init__(self, client):
        self._client = client

    def create_rest_api(self, name: str = INT_API_NAME) -> dict:
        r = self._client.post("/restapis", json={"name": name})
        return r.json()

    def create_child_resource(
        self, api_id: str, parent_id: str, path_part: str = INT_RESOURCE_PATH
    ) -> dict:
        r = self._client.post(
            f"/restapis/{api_id}/resources/{parent_id}", json={"pathPart": path_part}
        )
        return r.json()

    def put_method(self, api_id: str, resource_id: str, http_method: str = INT_HTTP_METHOD) -> dict:
        r = self._client.put(
            f"/restapis/{api_id}/resources/{resource_id}/methods/{http_method}",
            json={"authorizationType": "NONE"},
        )
        return r.json()

    def put_integration(
        self, api_id: str, resource_id: str, http_method: str = INT_HTTP_METHOD
    ) -> dict:
        r = self._client.put(
            f"/restapis/{api_id}/resources/{resource_id}/methods/{http_method}/integration",
            json={"type": INT_INTEGRATION_TYPE},
        )
        return r.json()

    def create_deployment(self, api_id: str) -> dict:
        r = self._client.post(f"/restapis/{api_id}/deployments", json={})
        return r.json()

    def create_stage(self, api_id: str, stage_name: str, deployment_id: str) -> dict:
        r = self._client.post(
            f"/restapis/{api_id}/stages",
            json={"stageName": stage_name, "deploymentId": deployment_id},
        )
        return r.json()

    def setup_api_with_integration(self, api_name: str = INT_API_NAME):
        """Create a full API with resource, method, and integration.

        Returns (api_id, resource_id).
        """
        api_body = self.create_rest_api(api_name)
        api_id = api_body["id"]
        root_resource_id = api_body["rootResourceId"]
        resource_body = self.create_child_resource(api_id, root_resource_id)
        resource_id = resource_body["id"]
        self.put_method(api_id, resource_id)
        self.put_integration(api_id, resource_id)
        return (api_id, resource_id)

    def setup_api_with_stage(
        self, stage_name: str, api_name: str = INT_API_NAME
    ) -> tuple[str, str]:
        """Create a full API + deployment + stage. Return (api_id, deployment_id)."""
        api_body = self.create_rest_api(api_name)
        api_id = api_body["id"]
        deployment_body = self.create_deployment(api_id)
        deployment_id = deployment_body["id"]
        self.create_stage(api_id, stage_name, deployment_id)
        return (api_id, deployment_id)
