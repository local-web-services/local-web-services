"""API Gateway management HTTP routes.

Implements the API Gateway REST (V1) and HTTP (V2) management APIs that
the AWS SDK and Terraform use to create/read/update/delete REST APIs,
resources, methods, integrations, deployments, stages, and HTTP APIs.

The V2 catch-all handler also acts as a proxy — when a request matches
a registered V2 route, it invokes the corresponding Lambda function via
the shared ``LambdaRegistry``.
"""

from __future__ import annotations

import json
import re
import time
import uuid
from dataclasses import dataclass, field
from typing import TYPE_CHECKING, Any

from fastapi import APIRouter, FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware

if TYPE_CHECKING:
    from lws.providers.lambda_runtime.routes import LambdaRegistry

_logger = get_logger("ldk.apigateway-mgmt")


# ---------------------------------------------------------------------------
# In-memory state
# ---------------------------------------------------------------------------


@dataclass
class _RestApi:
    id: str
    name: str
    description: str = ""
    created_date: float = field(default_factory=time.time)
    root_resource_id: str = field(default_factory=lambda: str(uuid.uuid4())[:10])
    resources: dict[str, dict[str, Any]] = field(default_factory=dict)
    deployments: dict[str, dict[str, Any]] = field(default_factory=dict)
    stages: dict[str, dict[str, Any]] = field(default_factory=dict)

    def __post_init__(self) -> None:
        # Every REST API has a root resource "/"
        self.resources[self.root_resource_id] = {
            "id": self.root_resource_id,
            "path": "/",
            "resourceMethods": {},
        }


class _ApiGatewayState:
    """Thread-safe in-memory store for API Gateway resources."""

    def __init__(self) -> None:
        self._apis: dict[str, _RestApi] = {}

    def create_rest_api(self, name: str, description: str = "") -> _RestApi:
        api_id = str(uuid.uuid4())[:10]
        api = _RestApi(id=api_id, name=name, description=description)
        self._apis[api_id] = api
        return api

    def get_rest_api(self, api_id: str) -> _RestApi | None:
        return self._apis.get(api_id)

    def list_rest_apis(self) -> list[_RestApi]:
        return list(self._apis.values())

    def delete_rest_api(self, api_id: str) -> bool:
        return self._apis.pop(api_id, None) is not None


# ---------------------------------------------------------------------------
# V2 (HTTP API) In-memory state
# ---------------------------------------------------------------------------

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


@dataclass
class _HttpApi:
    api_id: str
    name: str
    protocol_type: str = "HTTP"
    description: str = ""
    created_date: str = field(default_factory=lambda: "2024-01-01T00:00:00Z")
    routes: dict[str, dict[str, Any]] = field(default_factory=dict)
    integrations: dict[str, dict[str, Any]] = field(default_factory=dict)
    stages: dict[str, dict[str, Any]] = field(default_factory=dict)


class _ApiGatewayV2State:
    """In-memory store for API Gateway V2 (HTTP API) resources."""

    def __init__(self) -> None:
        self._apis: dict[str, _HttpApi] = {}

    def create_api(self, name: str, protocol_type: str = "HTTP", description: str = "") -> _HttpApi:
        api_id = str(uuid.uuid4())[:10]
        api = _HttpApi(
            api_id=api_id, name=name, protocol_type=protocol_type, description=description
        )
        self._apis[api_id] = api
        return api

    def get_api(self, api_id: str) -> _HttpApi | None:
        return self._apis.get(api_id)

    def list_apis(self) -> list[_HttpApi]:
        return list(self._apis.values())

    def delete_api(self, api_id: str) -> bool:
        return self._apis.pop(api_id, None) is not None


# ---------------------------------------------------------------------------
# Router
# ---------------------------------------------------------------------------


class ApiGatewayManagementRouter:
    """Route API Gateway management requests to the in-memory state."""

    def __init__(self) -> None:
        self._state = _ApiGatewayState()
        self.router = APIRouter()
        self._register_routes()

    def _register_routes(self) -> None:
        r = self.router

        # REST APIs
        r.add_api_route("/restapis", self._create_rest_api, methods=["POST"])
        r.add_api_route("/restapis", self._list_rest_apis, methods=["GET"])
        r.add_api_route("/restapis/{rest_api_id}", self._get_rest_api, methods=["GET"])
        r.add_api_route("/restapis/{rest_api_id}", self._delete_rest_api, methods=["DELETE"])
        r.add_api_route("/restapis/{rest_api_id}", self._update_rest_api, methods=["PATCH"])

        # Resources
        r.add_api_route(
            "/restapis/{rest_api_id}/resources",
            self._get_resources,
            methods=["GET"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/resources/{resource_id}",
            self._get_resource,
            methods=["GET"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/resources/{resource_id}",
            self._create_resource,
            methods=["POST"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/resources/{resource_id}",
            self._delete_resource,
            methods=["DELETE"],
        )

        # Methods
        r.add_api_route(
            "/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}",
            self._put_method,
            methods=["PUT"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}",
            self._get_method,
            methods=["GET"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}",
            self._delete_method,
            methods=["DELETE"],
        )

        # Integrations
        r.add_api_route(
            "/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}/integration",
            self._put_integration,
            methods=["PUT"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}/integration",
            self._get_integration,
            methods=["GET"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}/integration",
            self._delete_integration,
            methods=["DELETE"],
        )

        # Integration responses
        r.add_api_route(
            "/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}"
            "/integration/responses/{status_code}",
            self._put_integration_response,
            methods=["PUT"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}"
            "/integration/responses/{status_code}",
            self._get_integration_response,
            methods=["GET"],
        )

        # Method responses
        r.add_api_route(
            "/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}"
            "/responses/{status_code}",
            self._put_method_response,
            methods=["PUT"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}"
            "/responses/{status_code}",
            self._get_method_response,
            methods=["GET"],
        )

        # Deployments
        r.add_api_route(
            "/restapis/{rest_api_id}/deployments",
            self._create_deployment,
            methods=["POST"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/deployments",
            self._list_deployments,
            methods=["GET"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/deployments/{deployment_id}",
            self._get_deployment,
            methods=["GET"],
        )

        # Stages
        r.add_api_route(
            "/restapis/{rest_api_id}/stages",
            self._create_stage,
            methods=["POST"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/stages/{stage_name}",
            self._get_stage,
            methods=["GET"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/stages/{stage_name}",
            self._update_stage,
            methods=["PATCH"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/stages/{stage_name}",
            self._delete_stage,
            methods=["DELETE"],
        )

    # -- REST APIs -----------------------------------------------------------

    async def _create_rest_api(self, request: Request) -> Response:
        body = await _parse_body(request)
        name = body.get("name", "")
        description = body.get("description", "")
        api = self._state.create_rest_api(name, description)
        return _json_response(_format_rest_api(api), 201)

    async def _list_rest_apis(self, request: Request) -> Response:
        apis = self._state.list_rest_apis()
        return _json_response({"item": [_format_rest_api(a) for a in apis]})

    async def _get_rest_api(self, rest_api_id: str) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        return _json_response(_format_rest_api(api))

    async def _update_rest_api(self, rest_api_id: str, request: Request) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        body = await _parse_body(request)
        for op in body.get("patchOperations", []):
            if op.get("path") == "/name" and op.get("op") == "replace":
                api.name = op.get("value", api.name)
            elif op.get("path") == "/description" and op.get("op") == "replace":
                api.description = op.get("value", api.description)
        return _json_response(_format_rest_api(api))

    async def _delete_rest_api(self, rest_api_id: str) -> Response:
        self._state.delete_rest_api(rest_api_id)
        return Response(status_code=202)

    # -- Resources -----------------------------------------------------------

    async def _get_resources(self, rest_api_id: str) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        return _json_response({"item": list(api.resources.values())})

    async def _get_resource(self, rest_api_id: str, resource_id: str) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        resource = api.resources.get(resource_id)
        if resource is None:
            return _not_found("Resource", resource_id)
        return _json_response(resource)

    async def _create_resource(
        self, rest_api_id: str, resource_id: str, request: Request
    ) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        parent = api.resources.get(resource_id)
        if parent is None:
            return _not_found("Resource", resource_id)

        body = await _parse_body(request)
        path_part = body.get("pathPart", "")
        new_id = str(uuid.uuid4())[:10]
        parent_path = parent["path"].rstrip("/")
        new_resource = {
            "id": new_id,
            "parentId": resource_id,
            "pathPart": path_part,
            "path": f"{parent_path}/{path_part}",
            "resourceMethods": {},
        }
        api.resources[new_id] = new_resource
        return _json_response(new_resource, 201)

    async def _delete_resource(self, rest_api_id: str, resource_id: str) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is not None:
            api.resources.pop(resource_id, None)
        return Response(status_code=202)

    # -- Methods -------------------------------------------------------------

    async def _put_method(
        self,
        rest_api_id: str,
        resource_id: str,
        http_method: str,
        request: Request,
    ) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        resource = api.resources.get(resource_id)
        if resource is None:
            return _not_found("Resource", resource_id)

        body = await _parse_body(request)
        method_data = {
            "httpMethod": http_method,
            "authorizationType": body.get("authorizationType", "NONE"),
            "apiKeyRequired": body.get("apiKeyRequired", False),
            "requestParameters": body.get("requestParameters", {}),
        }
        resource["resourceMethods"][http_method] = method_data
        return _json_response(method_data, 201)

    async def _get_method(self, rest_api_id: str, resource_id: str, http_method: str) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        resource = api.resources.get(resource_id)
        if resource is None:
            return _not_found("Resource", resource_id)
        method = resource["resourceMethods"].get(http_method)
        if method is None:
            return _not_found("Method", http_method)
        return _json_response(method)

    async def _delete_method(
        self, rest_api_id: str, resource_id: str, http_method: str
    ) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is not None:
            resource = api.resources.get(resource_id)
            if resource is not None:
                resource["resourceMethods"].pop(http_method, None)
        return Response(status_code=204)

    # -- Integrations --------------------------------------------------------

    async def _put_integration(
        self,
        rest_api_id: str,
        resource_id: str,
        http_method: str,
        request: Request,
    ) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        resource = api.resources.get(resource_id)
        if resource is None:
            return _not_found("Resource", resource_id)

        body = await _parse_body(request)
        integration = {
            "type": body.get("type", "AWS_PROXY"),
            "httpMethod": body.get("httpMethod", "POST"),
            "uri": body.get("uri", ""),
            "integrationHttpMethod": body.get("integrationHttpMethod", "POST"),
        }
        method = resource["resourceMethods"].get(http_method, {})
        method["methodIntegration"] = integration
        resource["resourceMethods"][http_method] = method
        return _json_response(integration, 201)

    async def _get_integration(
        self, rest_api_id: str, resource_id: str, http_method: str
    ) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        resource = api.resources.get(resource_id)
        if resource is None:
            return _not_found("Resource", resource_id)
        method = resource["resourceMethods"].get(http_method, {})
        integration = method.get("methodIntegration")
        if integration is None:
            return _not_found("Integration", http_method)
        return _json_response(integration)

    async def _delete_integration(
        self, rest_api_id: str, resource_id: str, http_method: str
    ) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is not None:
            resource = api.resources.get(resource_id)
            if resource is not None:
                method = resource["resourceMethods"].get(http_method, {})
                method.pop("methodIntegration", None)
        return Response(status_code=204)

    # -- Integration responses -----------------------------------------------

    async def _put_integration_response(
        self,
        rest_api_id: str,
        resource_id: str,
        http_method: str,
        status_code: str,
        request: Request,
    ) -> Response:
        body = await _parse_body(request)
        resp_data = {
            "statusCode": status_code,
            "responseTemplates": body.get("responseTemplates", {}),
            "responseParameters": body.get("responseParameters", {}),
        }
        return _json_response(resp_data, 201)

    async def _get_integration_response(
        self,
        rest_api_id: str,
        resource_id: str,
        http_method: str,
        status_code: str,
    ) -> Response:
        return _json_response({"statusCode": status_code})

    # -- Method responses ----------------------------------------------------

    async def _put_method_response(
        self,
        rest_api_id: str,
        resource_id: str,
        http_method: str,
        status_code: str,
        request: Request,
    ) -> Response:
        body = await _parse_body(request)
        resp_data = {
            "statusCode": status_code,
            "responseModels": body.get("responseModels", {}),
            "responseParameters": body.get("responseParameters", {}),
        }
        return _json_response(resp_data, 201)

    async def _get_method_response(
        self,
        rest_api_id: str,
        resource_id: str,
        http_method: str,
        status_code: str,
    ) -> Response:
        return _json_response({"statusCode": status_code})

    # -- Deployments ---------------------------------------------------------

    async def _create_deployment(self, rest_api_id: str, request: Request) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)

        body = await _parse_body(request)
        deployment_id = str(uuid.uuid4())[:10]
        deployment = {
            "id": deployment_id,
            "createdDate": time.time(),
            "description": body.get("description", ""),
        }
        api.deployments[deployment_id] = deployment
        return _json_response(deployment, 201)

    async def _list_deployments(self, rest_api_id: str) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        return _json_response({"item": list(api.deployments.values())})

    async def _get_deployment(self, rest_api_id: str, deployment_id: str) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        deployment = api.deployments.get(deployment_id)
        if deployment is None:
            return _not_found("Deployment", deployment_id)
        return _json_response(deployment)

    # -- Stages --------------------------------------------------------------

    async def _create_stage(self, rest_api_id: str, request: Request) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)

        body = await _parse_body(request)
        stage_name = body.get("stageName", "")
        deployment_id = body.get("deploymentId", "")
        stage = {
            "stageName": stage_name,
            "deploymentId": deployment_id,
            "createdDate": time.time(),
            "lastUpdatedDate": time.time(),
            "methodSettings": {},
        }
        api.stages[stage_name] = stage
        return _json_response(stage, 201)

    async def _get_stage(self, rest_api_id: str, stage_name: str) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        stage = api.stages.get(stage_name)
        if stage is None:
            return _not_found("Stage", stage_name)
        return _json_response(stage)

    async def _update_stage(self, rest_api_id: str, stage_name: str, request: Request) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        stage = api.stages.get(stage_name)
        if stage is None:
            return _not_found("Stage", stage_name)
        stage["lastUpdatedDate"] = time.time()
        return _json_response(stage)

    async def _delete_stage(self, rest_api_id: str, stage_name: str) -> Response:
        api = self._state.get_rest_api(rest_api_id)
        if api is not None:
            api.stages.pop(stage_name, None)
        return Response(status_code=202)


# ---------------------------------------------------------------------------
# V2 Router
# ---------------------------------------------------------------------------


class ApiGatewayV2Router:
    """Route API Gateway V2 (HTTP API) management requests."""

    def __init__(self, lambda_registry: LambdaRegistry | None = None) -> None:
        self._state = _ApiGatewayV2State()
        self._lambda_registry = lambda_registry
        self.router = APIRouter()
        self._register_routes()

    def _register_routes(self) -> None:
        r = self.router

        # APIs
        r.add_api_route("/v2/apis", self._create_api, methods=["POST"])
        r.add_api_route("/v2/apis", self._list_apis, methods=["GET"])
        r.add_api_route("/v2/apis/{api_id}", self._get_api, methods=["GET"])
        r.add_api_route("/v2/apis/{api_id}", self._update_api, methods=["PATCH"])
        r.add_api_route("/v2/apis/{api_id}", self._delete_api, methods=["DELETE"])

        # Stages
        r.add_api_route("/v2/apis/{api_id}/stages", self._create_stage, methods=["POST"])
        r.add_api_route("/v2/apis/{api_id}/stages/{stage_name}", self._get_stage, methods=["GET"])
        r.add_api_route(
            "/v2/apis/{api_id}/stages/{stage_name}", self._update_stage, methods=["PATCH"]
        )
        r.add_api_route(
            "/v2/apis/{api_id}/stages/{stage_name}", self._delete_stage, methods=["DELETE"]
        )

        # Integrations
        r.add_api_route(
            "/v2/apis/{api_id}/integrations", self._create_integration, methods=["POST"]
        )
        r.add_api_route("/v2/apis/{api_id}/integrations", self._list_integrations, methods=["GET"])
        r.add_api_route(
            "/v2/apis/{api_id}/integrations/{integration_id}",
            self._get_integration,
            methods=["GET"],
        )
        r.add_api_route(
            "/v2/apis/{api_id}/integrations/{integration_id}",
            self._delete_integration,
            methods=["DELETE"],
        )

        # Routes
        r.add_api_route("/v2/apis/{api_id}/routes", self._create_route, methods=["POST"])
        r.add_api_route("/v2/apis/{api_id}/routes", self._list_routes, methods=["GET"])
        r.add_api_route("/v2/apis/{api_id}/routes/{route_id}", self._get_route, methods=["GET"])
        r.add_api_route(
            "/v2/apis/{api_id}/routes/{route_id}", self._delete_route, methods=["DELETE"]
        )

        # Stages (list) - registered before the stage name GET
        r.add_api_route("/v2/apis/{api_id}/stages", self._list_stages, methods=["GET"])

    # -- APIs ----------------------------------------------------------------

    async def _create_api(self, request: Request) -> Response:
        body = await _parse_body(request)
        name = body.get("name", body.get("Name", ""))
        protocol_type = body.get("protocolType", body.get("ProtocolType", "HTTP"))
        description = body.get("description", body.get("Description", ""))
        api = self._state.create_api(name, protocol_type, description)
        _logger.info("V2 CreateApi: name=%s id=%s", name, api.api_id)
        return _json_response(_format_http_api(api), 201)

    async def _list_apis(self, request: Request) -> Response:
        apis = self._state.list_apis()
        return _json_response({"items": [_format_http_api(a) for a in apis]})

    async def _get_api(self, api_id: str) -> Response:
        api = self._state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        return _json_response(_format_http_api(api))

    async def _update_api(self, api_id: str, request: Request) -> Response:
        api = self._state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        body = await _parse_body(request)
        if "name" in body or "Name" in body:
            api.name = body.get("name", body.get("Name", api.name))
        if "description" in body or "Description" in body:
            api.description = body.get("description", body.get("Description", api.description))
        return _json_response(_format_http_api(api))

    async def _delete_api(self, api_id: str) -> Response:
        self._state.delete_api(api_id)
        return Response(status_code=204)

    # -- Stages --------------------------------------------------------------

    async def _create_stage(self, api_id: str, request: Request) -> Response:
        api = self._state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        body = await _parse_body(request)
        stage_name = body.get("stageName", body.get("StageName", "$default"))
        stage = {
            "stageName": stage_name,
            "apiId": api_id,
            "createdDate": "2024-01-01T00:00:00Z",
            "lastUpdatedDate": "2024-01-01T00:00:00Z",
            "defaultRouteSettings": {},
            "stageVariables": body.get("stageVariables", {}),
            "autoDeploy": body.get("autoDeploy", False),
        }
        api.stages[stage_name] = stage
        return _json_response(stage, 201)

    async def _get_stage(self, api_id: str, stage_name: str) -> Response:
        api = self._state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        stage = api.stages.get(stage_name)
        if stage is None:
            return _not_found("Stage", stage_name)
        return _json_response(stage)

    async def _update_stage(self, api_id: str, stage_name: str, request: Request) -> Response:
        api = self._state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        stage = api.stages.get(stage_name)
        if stage is None:
            return _not_found("Stage", stage_name)
        stage["lastUpdatedDate"] = "2024-01-01T00:00:00Z"
        return _json_response(stage)

    async def _delete_stage(self, api_id: str, stage_name: str) -> Response:
        api = self._state.get_api(api_id)
        if api is not None:
            api.stages.pop(stage_name, None)
        return Response(status_code=204)

    # -- Integrations --------------------------------------------------------

    async def _create_integration(self, api_id: str, request: Request) -> Response:
        api = self._state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        body = await _parse_body(request)
        integration_id = str(uuid.uuid4())[:7]
        int_type = body.get("integrationType", body.get("IntegrationType", "AWS_PROXY"))
        int_uri = body.get("integrationUri", body.get("IntegrationUri", ""))
        int_method = body.get("integrationMethod", body.get("IntegrationMethod", "POST"))
        fmt_ver = body.get("payloadFormatVersion", body.get("PayloadFormatVersion", "2.0"))
        integration = {
            "integrationId": integration_id,
            "integrationType": int_type,
            "integrationUri": int_uri,
            "integrationMethod": int_method,
            "payloadFormatVersion": fmt_ver,
            "connectionType": body.get("connectionType", "INTERNET"),
        }
        api.integrations[integration_id] = integration
        _logger.debug(
            "V2 created integration: id=%s type=%s uri=%s",
            integration_id,
            int_type,
            int_uri,
        )
        return _json_response(integration, 201)

    async def _get_integration(self, api_id: str, integration_id: str) -> Response:
        api = self._state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        integration = api.integrations.get(integration_id)
        if integration is None:
            return _not_found("Integration", integration_id)
        return _json_response(integration)

    async def _list_integrations(self, api_id: str) -> Response:
        api = self._state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        return _json_response({"items": list(api.integrations.values())})

    async def _delete_integration(self, api_id: str, integration_id: str) -> Response:
        api = self._state.get_api(api_id)
        if api is not None:
            api.integrations.pop(integration_id, None)
        return Response(status_code=204)

    # -- Routes --------------------------------------------------------------

    async def _create_route(self, api_id: str, request: Request) -> Response:
        api = self._state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        body = await _parse_body(request)
        route_id = str(uuid.uuid4())[:7]
        route_key = body.get("routeKey", body.get("RouteKey", ""))
        target = body.get("target", body.get("Target", ""))
        route = {
            "routeId": route_id,
            "routeKey": route_key,
            "target": target,
            "apiId": api_id,
        }
        api.routes[route_id] = route
        _logger.debug("V2 created route: key=%r target=%r api=%s", route_key, target, api_id)
        return _json_response(route, 201)

    async def _get_route(self, api_id: str, route_id: str) -> Response:
        api = self._state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        route = api.routes.get(route_id)
        if route is None:
            return _not_found("Route", route_id)
        return _json_response(route)

    async def _list_routes(self, api_id: str) -> Response:
        api = self._state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        return _json_response({"items": list(api.routes.values())})

    async def _delete_route(self, api_id: str, route_id: str) -> Response:
        api = self._state.get_api(api_id)
        if api is not None:
            api.routes.pop(route_id, None)
        return Response(status_code=204)

    async def _list_stages(self, api_id: str) -> Response:
        api = self._state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        return _json_response({"items": list(api.stages.values())})

    # -- Proxy ---------------------------------------------------------------

    def _find_matching_route(
        self, method: str, path: str
    ) -> tuple[_HttpApi, dict[str, Any], dict[str, Any]] | None:
        """Find a V2 route matching the given method and path.

        Returns (api, route, integration) or None.
        """
        default_match = None
        for api in self._state.list_apis():
            for route in api.routes.values():
                route_key = route.get("routeKey", "")
                # Route key format: "METHOD /path" or "$default"
                if route_key == "$default":
                    target = route.get("target", "")
                    integration_id = target.replace("integrations/", "")
                    integration = api.integrations.get(integration_id)
                    if integration:
                        default_match = (api, route, integration)
                    continue

                parts = route_key.split(" ", 1)
                if len(parts) != 2:
                    continue
                route_method, route_path = parts
                if route_method == method and _route_path_matches(route_path, path):
                    target = route.get("target", "")
                    integration_id = target.replace("integrations/", "")
                    integration = api.integrations.get(integration_id)
                    if integration:
                        return api, route, integration

        # Fall back to $default route if no specific match
        return default_match

    async def proxy_request(self, request: Request, path: str) -> Response | None:
        """Try to proxy a request through V2 routes. Returns None if no match."""
        method = request.method
        request_path = f"/{path}" if not path.startswith("/") else path

        api_count = len(self._state.list_apis())
        _logger.info("V2 proxy: trying %s %s (apis=%d)", method, request_path, api_count)

        match = self._find_matching_route(method, request_path)
        if match is None:
            return None

        api, route, integration = match
        integration_uri = integration.get("integrationUri", "")

        # Extract Lambda function name from the integration URI
        # Format: arn:aws:lambda:region:account:function:name or
        # arn:aws:apigateway:region:lambda:path/2015-03-31/functions/arn:aws:.../invocations
        function_name = _extract_function_name(integration_uri)
        if not function_name or self._lambda_registry is None:
            return None

        compute = self._lambda_registry.get_compute(function_name)
        if compute is None:
            return None

        # Build API Gateway V2 event
        body_bytes = await request.body()
        body_str = body_bytes.decode("utf-8") if body_bytes else ""

        route_key = route.get("routeKey", "")
        # Extract path parameters from the route pattern
        route_path = route_key.split(" ", 1)[-1] if " " in route_key else ""
        path_params = _extract_path_parameters(route_path, request_path)

        event = _build_apigw_v2_event(request, request_path, body_str, route_key, path_params)

        from lws.interfaces import LambdaContext

        request_id = str(uuid.uuid4())
        context = LambdaContext(
            function_name=function_name,
            memory_limit_in_mb=128,
            timeout_seconds=30,
            aws_request_id=request_id,
            invoked_function_arn=f"arn:aws:lambda:{_REGION}:{_ACCOUNT_ID}:function:{function_name}",
        )

        result = await compute.invoke(event, context)

        if result.error:
            return _json_response({"message": result.error}, 502)

        return _build_proxy_response(result.payload)


def _route_path_matches(route_path: str, request_path: str) -> bool:
    """Check if a route path pattern matches the request path.

    Handles exact paths (``/orders``) and path variables like
    ``/orders/{id}`` or ``/orders/{proxy+}``.
    """
    if route_path == request_path:
        return True

    # Convert route path variables to regex
    # {proxy+} matches one or more path segments
    pattern = re.sub(r"\{[^}]+\+\}", r"(.+)", route_path)
    # {param} matches a single path segment
    pattern = re.sub(r"\{[^}]+\}", r"([^/]+)", pattern)
    pattern = f"^{pattern}$"

    return bool(re.match(pattern, request_path))


def _extract_path_parameters(route_path: str, request_path: str) -> dict[str, str] | None:
    """Extract path parameters from a route pattern and request path.

    For route ``/orders/{id}`` and path ``/orders/abc``, returns ``{"id": "abc"}``.
    Returns ``None`` if there are no path variables.
    """
    param_names = re.findall(r"\{([^}]+)\}", route_path)
    if not param_names:
        return None

    # Build regex with named groups
    pattern = route_path
    for name in param_names:
        if name.endswith("+"):
            clean = name.rstrip("+")
            pattern = pattern.replace(f"{{{name}}}", f"(?P<{clean}>.+)")
        else:
            pattern = pattern.replace(f"{{{name}}}", f"(?P<{name}>[^/]+)")
    pattern = f"^{pattern}$"

    m = re.match(pattern, request_path)
    if m:
        return m.groupdict()
    return None


def _extract_function_name(uri: str) -> str | None:
    """Extract Lambda function name from an integration URI.

    Handles multiple URI formats:
    - ``arn:aws:lambda:REGION:ACCOUNT:function:NAME``
    - ``arn:aws:apigateway:REGION:lambda:path/.../functions/ARN/invocations``
    - Plain function name
    """
    # apigateway invoke_arn format:
    # arn:aws:apigateway:REGION:lambda:path/2015-03-31/functions/FUNC_ARN/invocations
    if "/functions/" in uri and "/invocations" in uri:
        # Extract the function ARN between /functions/ and /invocations
        func_arn = uri.split("/functions/")[-1].split("/invocations")[0]
        # Now extract the function name from the ARN
        if ":function:" in func_arn:
            return func_arn.split(":function:")[-1]
        return func_arn

    # Direct Lambda ARN: arn:aws:lambda:region:account:function:name
    if ":function:" in uri:
        return uri.split(":function:")[-1].split("/")[0]

    # Just a function name
    if uri and ":" not in uri and "/" not in uri:
        return uri
    return None


def _build_apigw_v2_event(
    request: Request,
    path: str,
    body: str,
    route_key: str,
    path_parameters: dict[str, str] | None = None,
) -> dict[str, Any]:
    """Build an API Gateway V2 HTTP API event."""
    headers = dict(request.headers)
    query_params = dict(request.query_params)

    event: dict[str, Any] = {
        "version": "2.0",
        "routeKey": route_key,
        "rawPath": path,
        "rawQueryString": str(request.url.query) if request.url.query else "",
        "headers": headers,
        "queryStringParameters": query_params if query_params else None,
        "body": body or None,
        "isBase64Encoded": False,
        "requestContext": {
            "accountId": _ACCOUNT_ID,
            "apiId": "local",
            "http": {
                "method": request.method,
                "path": path,
                "protocol": "HTTP/1.1",
                "sourceIp": "127.0.0.1",
                "userAgent": headers.get("user-agent", ""),
            },
            "requestId": str(uuid.uuid4()),
            "routeKey": route_key,
            "stage": "$default",
            "time": time.strftime("%d/%b/%Y:%H:%M:%S +0000", time.gmtime()),
            "timeEpoch": int(time.time() * 1000),
        },
    }
    if path_parameters:
        event["pathParameters"] = path_parameters
    return event


def _build_proxy_response(payload: dict | None) -> Response:
    """Convert Lambda response to HTTP response."""
    if payload is None:
        return _json_response({})

    status_code = payload.get("statusCode", 200)
    resp_headers = payload.get("headers", {})
    resp_body = payload.get("body", "")

    response = Response(
        content=resp_body if isinstance(resp_body, str) else json.dumps(resp_body),
        status_code=status_code,
        media_type=resp_headers.get(
            "content-type", resp_headers.get("Content-Type", "application/json")
        ),
    )
    for k, v in resp_headers.items():
        if k.lower() != "content-type":
            response.headers[k] = str(v)
    return response


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _format_rest_api(api: _RestApi) -> dict[str, Any]:
    return {
        "id": api.id,
        "name": api.name,
        "description": api.description,
        "createdDate": api.created_date,
        "rootResourceId": api.root_resource_id,
        "apiKeySource": "HEADER",
        "endpointConfiguration": {"types": ["REGIONAL"]},
    }


def _format_http_api(api: _HttpApi) -> dict[str, Any]:
    return {
        "apiId": api.api_id,
        "name": api.name,
        "protocolType": api.protocol_type,
        "description": api.description,
        "createdDate": api.created_date,
        "apiEndpoint": f"http://localhost/{api.api_id}",
    }


async def _parse_body(request: Request) -> dict:
    body_bytes = await request.body()
    if not body_bytes:
        return {}
    try:
        return json.loads(body_bytes)
    except json.JSONDecodeError:
        return {}


def _json_response(data: dict, status_code: int = 200) -> Response:
    return Response(
        content=json.dumps(data, default=str),
        status_code=status_code,
        media_type="application/json",
    )


def _not_found(resource_type: str, resource_id: str) -> Response:
    return _json_response(
        {"message": f"{resource_type} not found: {resource_id}"},
        status_code=404,
    )


# ---------------------------------------------------------------------------
# App factory
# ---------------------------------------------------------------------------


def create_apigateway_management_app(
    lambda_registry: LambdaRegistry | None = None,
) -> FastAPI:
    """Create a FastAPI app that speaks the API Gateway management protocol.

    Args:
        lambda_registry: Optional shared registry for Lambda compute providers.
            When provided, V2 routes and proxy invocation are enabled.
    """
    app = FastAPI(title="LDK API Gateway Management")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="apigateway-mgmt")

    # V1 management routes
    v1_router = ApiGatewayManagementRouter()

    # V2 management routes (+ proxy)
    v2_router = ApiGatewayV2Router(lambda_registry=lambda_registry)

    # Include V2 first so /v2/... paths match before the V1 catch-all
    app.include_router(v2_router.router)
    app.include_router(v1_router.router)

    # Wire V2 proxy into the catch-all: override the V1 stub to also try V2 proxy
    @app.api_route("/{path:path}", methods=["GET", "POST", "PUT", "PATCH", "DELETE"])
    async def _catch_all_with_proxy(request: Request, path: str) -> Response:
        # Try V2 proxy first
        if lambda_registry is not None:
            proxy_resp = await v2_router.proxy_request(request, path)
            if proxy_resp is not None:
                return proxy_resp
        # Fall back to stub — include diagnostic info
        v2_apis = v2_router._state.list_apis()
        v2_route_count = sum(len(a.routes) for a in v2_apis)
        reg_funcs = list(lambda_registry._functions.keys()) if lambda_registry else []
        _logger.warning(
            "Unknown API Gateway path: %s %s (v2_apis=%d, v2_routes=%d, lambda_funcs=%s)",
            request.method,
            path,
            len(v2_apis),
            v2_route_count,
            reg_funcs,
        )
        return _json_response(
            {"message": f"lws: API Gateway has no route for {request.method} /{path}"},
            404,
        )

    return app
