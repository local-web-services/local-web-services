"""Test client for apigateway_sqs tests."""

from __future__ import annotations

import json
import urllib.request

from .constants import _ACCOUNT, _REGION, _STAGE, TEST_API, TEST_QUEUE


class ApigatewaySqsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _apigateway = lws_session.client("apigateway")
        self._apigateway = _apigateway
        _sqs = lws_session.client("sqs")
        self._sqs = _sqs

    def create_api(self, name=TEST_API):
        resp = self._apigateway.create_rest_api(name=name)
        return resp["id"]

    def get_api_id(self, name=TEST_API):
        resp = self._apigateway.get_rest_apis()
        for api in resp.get("items", []):
            if api["name"] == name:
                return api["id"]
        return None

    def create_queue(self, name=TEST_QUEUE):
        self._sqs.create_queue(QueueName=name)

    def queue_url(self, name=TEST_QUEUE):
        return self._session.queue_url(name)

    def configure_sqs_integration(self, api_id: str) -> None:
        """Configure a direct SQS SendMessage integration on the root resource."""
        apigw = self._apigateway
        resources_resp = apigw.get_resources(restApiId=api_id)
        root_resource = next(r for r in resources_resp["items"] if r["path"] == "/")
        root_resource_id = root_resource["id"]
        apigw.put_method(
            restApiId=api_id,
            resourceId=root_resource_id,
            httpMethod="POST",
            authorizationType="NONE",
        )
        integration_uri = f"arn:aws:apigateway:{_REGION}:sqs:path/{_ACCOUNT}/{TEST_QUEUE}"
        apigw.put_integration(
            restApiId=api_id,
            resourceId=root_resource_id,
            httpMethod="POST",
            type="AWS",
            integrationHttpMethod="POST",
            uri=integration_uri,
        )
        deploy_resp = apigw.create_deployment(restApiId=api_id, description="e2e")
        apigw.create_stage(restApiId=api_id, stageName=_STAGE, deploymentId=deploy_resp["id"])

    def invoke_api(self, api_id: str, body: dict) -> dict:
        """POST to the deployed API stage root resource using urllib."""
        port = self._session.port_for("apigateway")
        url = f"http://127.0.0.1:{port}/{api_id}/{_STAGE}/"
        data = json.dumps(body).encode()
        req = urllib.request.Request(
            url, data=data, headers={"Content-Type": "application/json"}, method="POST"
        )
        try:
            with urllib.request.urlopen(req) as resp:
                return {"status_code": resp.status, "body": resp.read().decode()}
        except urllib.error.HTTPError as exc:
            return {"status_code": exc.code, "body": exc.read().decode()}
