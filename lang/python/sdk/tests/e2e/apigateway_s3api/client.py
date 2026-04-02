"""Test client for apigateway_s3api tests."""

from __future__ import annotations

import urllib.request

from .constants import _REGION, _STAGE, TEST_API, TEST_BUCKET, TEST_KEY


class ApigatewayS3apiTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _apigateway = lws_session.client("apigateway")
        self._apigateway = _apigateway
        _s3 = lws_session.client("s3")
        self._s3 = _s3

    def create_api(self, name=TEST_API):
        resp = self._apigateway.create_rest_api(name=name)
        return resp["id"]

    def get_api_id(self, name=TEST_API):
        resp = self._apigateway.get_rest_apis()
        for api in resp.get("items", []):
            if api["name"] == name:
                return api["id"]
        return None

    def create_bucket(self, name=TEST_BUCKET):
        try:
            self._s3.create_bucket(Bucket=name)
        except Exception:
            pass

    def configure_s3_integration(self, api_id: str) -> None:
        """Configure a direct S3 PutObject integration on the root resource."""
        apigw = self._apigateway
        resources_resp = apigw.get_resources(restApiId=api_id)
        root_resource = next(r for r in resources_resp["items"] if r["path"] == "/")
        root_resource_id = root_resource["id"]
        apigw.put_method(
            restApiId=api_id,
            resourceId=root_resource_id,
            httpMethod="PUT",
            authorizationType="NONE",
        )
        integration_uri = f"arn:aws:apigateway:{_REGION}:s3:path/{TEST_BUCKET}/{TEST_KEY}"
        apigw.put_integration(
            restApiId=api_id,
            resourceId=root_resource_id,
            httpMethod="PUT",
            type="AWS",
            integrationHttpMethod="PUT",
            uri=integration_uri,
        )
        deploy_resp = apigw.create_deployment(restApiId=api_id, description="e2e")
        apigw.create_stage(restApiId=api_id, stageName=_STAGE, deploymentId=deploy_resp["id"])

    def invoke_api_put(self, api_id: str, body: bytes) -> dict:
        """PUT to the deployed API stage root resource using urllib."""
        port = self._session.port_for("apigateway")
        url = f"http://127.0.0.1:{port}/{api_id}/{_STAGE}/"
        req = urllib.request.Request(
            url,
            data=body,
            headers={"Content-Type": "application/octet-stream"},
            method="PUT",
        )
        try:
            with urllib.request.urlopen(req) as resp:
                return {"status_code": resp.status, "body": resp.read().decode()}
        except urllib.error.HTTPError as exc:
            return {"status_code": exc.code, "body": exc.read().decode()}
