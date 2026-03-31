"""V1 REST API resource/method/integration/deployment/stage/authorizer route handlers."""

from __future__ import annotations

import time
import uuid
from typing import Any

from fastapi import Request, Response

from lws.providers._shared.request_helpers import parse_json_body
from lws.providers.apigateway._apigateway_state import (
    _ApiGatewayState,
    _json_response,
    _not_found,
    apply_stage_patch_op,
)
from lws.providers.apigateway._apigateway_v1_authorizers import _ApiGatewayAuthorizerMixin
from lws.providers.apigateway._apigateway_v1_dispatch import validate_integration_target


class ApiGatewayResourceRouter(_ApiGatewayAuthorizerMixin):
    """Mixin-style helper that registers resource/method/integration/deployment/stage routes.

    Expects ``self._state`` (``_ApiGatewayState``) and ``self.router`` to be set up by
    the host class before ``register_resource_routes`` is called.
    """

    def __init__(self, state: _ApiGatewayState, tracker: Any = None) -> None:
        self._res_state = state
        self._tracker = tracker
        self._service_providers: dict[str, Any] = {}

    def _get_api_lifecycle_error(self, rest_api_id: str) -> Response | None:
        """Return an error response if the REST API is in a transient lifecycle state."""
        if self._tracker is None:
            return None
        status = self._tracker.get_state(rest_api_id)
        if status == "CREATING":
            return _json_response(
                {"message": f"REST API '{rest_api_id}' is not yet ACTIVE"},
                status_code=409,
            )
        if status == "DELETING":
            return _not_found("RestApi", rest_api_id)
        return None

    def set_service_providers(self, providers: dict[str, Any]) -> None:
        """Register backend service providers for integration dispatch."""
        self._service_providers = providers

    def register_resource_routes(self, router) -> None:  # noqa: ANN001
        """Add all sub-API routes to *router*."""
        r = router

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
        # Authorizers
        r.add_api_route(
            "/restapis/{rest_api_id}/authorizers",
            self._create_authorizer,
            methods=["POST"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/authorizers",
            self._list_authorizers,
            methods=["GET"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/authorizers/{authorizer_id}",
            self._get_authorizer,
            methods=["GET"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/authorizers/{authorizer_id}",
            self._update_authorizer,
            methods=["PATCH"],
        )
        r.add_api_route(
            "/restapis/{rest_api_id}/authorizers/{authorizer_id}",
            self._delete_authorizer,
            methods=["DELETE"],
        )
        # Deployment delete
        r.add_api_route(
            "/restapis/{rest_api_id}/deployments/{deployment_id}",
            self._delete_deployment,
            methods=["DELETE"],
        )
        # Method update
        r.add_api_route(
            "/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}",
            self._update_method,
            methods=["PATCH"],
        )

    async def _get_resources(self, rest_api_id: str) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        return _json_response({"item": list(api.resources.values())})

    async def _get_resource(self, rest_api_id: str, resource_id: str) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        resource = api.resources.get(resource_id)
        if resource is None:
            return _not_found("Resource", resource_id)
        return _json_response(resource)

    async def _create_resource(
        self, rest_api_id: str, resource_id: str, request: Request
    ) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        parent = api.resources.get(resource_id)
        if parent is None:
            return _not_found("Resource", resource_id)

        body = await parse_json_body(request)
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
        api = self._res_state.get_rest_api(rest_api_id)
        if api is not None:
            api.resources.pop(resource_id, None)
        return Response(status_code=202)

    async def _put_method(
        self,
        rest_api_id: str,
        resource_id: str,
        http_method: str,
        request: Request,
    ) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        resource = api.resources.get(resource_id)
        if resource is None:
            return _not_found("Resource", resource_id)

        body = await parse_json_body(request)
        method_data = {
            "httpMethod": http_method,
            "authorizationType": body.get("authorizationType", "NONE"),
            "authorizerId": body.get("authorizerId"),
            "apiKeyRequired": body.get("apiKeyRequired", False),
            "requestParameters": body.get("requestParameters", {}),
        }
        resource["resourceMethods"][http_method] = method_data
        return _json_response(method_data, 201)

    async def _get_method(self, rest_api_id: str, resource_id: str, http_method: str) -> Response:
        method, err = self._resolve_method(rest_api_id, resource_id, http_method)
        if err is not None:
            return err
        return _json_response(method)

    async def _delete_method(
        self, rest_api_id: str, resource_id: str, http_method: str
    ) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is not None:
            resource = api.resources.get(resource_id)
            if resource is not None:
                resource["resourceMethods"].pop(http_method, None)
        return Response(status_code=204)

    async def _put_integration(
        self,
        rest_api_id: str,
        resource_id: str,
        http_method: str,
        request: Request,
    ) -> Response:
        err = self._get_api_lifecycle_error(rest_api_id)
        if err is not None:
            return err
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        resource = api.resources.get(resource_id)
        if resource is None:
            return _not_found("Resource", resource_id)

        body = await parse_json_body(request)
        uri = body.get("uri", "")
        err = validate_integration_target(uri, self._service_providers)
        if err is not None:
            return err
        integration = {
            "type": body.get("type", "AWS_PROXY"),
            "httpMethod": body.get("httpMethod", "POST"),
            "uri": uri,
            "integrationHttpMethod": body.get("integrationHttpMethod", "POST"),
        }
        method = resource["resourceMethods"].get(http_method, {})
        method["methodIntegration"] = integration
        resource["resourceMethods"][http_method] = method
        return _json_response(integration, 201)

    async def _get_integration(
        self, rest_api_id: str, resource_id: str, http_method: str
    ) -> Response:
        method, err = self._resolve_method(rest_api_id, resource_id, http_method)
        if err is not None:
            return err
        integration = method.get("methodIntegration")
        if integration is None:
            return _not_found("Integration", http_method)
        return _json_response(integration)

    async def _delete_integration(
        self, rest_api_id: str, resource_id: str, http_method: str
    ) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is not None:
            resource = api.resources.get(resource_id)
            if resource is not None:
                method = resource["resourceMethods"].get(http_method, {})
                method.pop("methodIntegration", None)
        return Response(status_code=204)

    async def _put_integration_response(  # pylint: disable=unused-argument
        self,
        rest_api_id: str,
        resource_id: str,
        http_method: str,
        status_code: str,
        request: Request,
    ) -> Response:
        body = await parse_json_body(request)
        resp_data = {
            "statusCode": status_code,
            "responseTemplates": body.get("responseTemplates", {}),
            "responseParameters": body.get("responseParameters", {}),
        }
        return _json_response(resp_data, 201)

    async def _get_integration_response(  # pylint: disable=unused-argument
        self,
        rest_api_id: str,
        resource_id: str,
        http_method: str,
        status_code: str,
    ) -> Response:
        return _json_response({"statusCode": status_code})

    async def _put_method_response(  # pylint: disable=unused-argument
        self,
        rest_api_id: str,
        resource_id: str,
        http_method: str,
        status_code: str,
        request: Request,
    ) -> Response:
        body = await parse_json_body(request)
        resp_data = {
            "statusCode": status_code,
            "responseModels": body.get("responseModels", {}),
            "responseParameters": body.get("responseParameters", {}),
        }
        return _json_response(resp_data, 201)

    async def _get_method_response(  # pylint: disable=unused-argument
        self,
        rest_api_id: str,
        resource_id: str,
        http_method: str,
        status_code: str,
    ) -> Response:
        return _json_response({"statusCode": status_code})

    async def _create_deployment(self, rest_api_id: str, request: Request) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)

        body = await parse_json_body(request)
        deployment_id = str(uuid.uuid4())[:10]
        deployment = {
            "id": deployment_id,
            "createdDate": time.time(),
            "description": body.get("description", ""),
        }
        api.deployments[deployment_id] = deployment
        return _json_response(deployment, 201)

    async def _list_deployments(self, rest_api_id: str) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        return _json_response({"item": list(api.deployments.values())})

    async def _get_deployment(self, rest_api_id: str, deployment_id: str) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        deployment = api.deployments.get(deployment_id)
        if deployment is None:
            return _not_found("Deployment", deployment_id)
        return _json_response(deployment)

    async def _create_stage(self, rest_api_id: str, request: Request) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        body = await parse_json_body(request)
        drs = body.get("defaultRouteSettings", {})
        stage = {
            "stageName": body.get("stageName", ""),
            "deploymentId": body.get("deploymentId", ""),
            "createdDate": time.time(),
            "lastUpdatedDate": time.time(),
            "methodSettings": {},
            "defaultRouteSettings": {
                "throttlingBurstLimit": drs.get("throttlingBurstLimit"),
                "throttlingRateLimit": drs.get("throttlingRateLimit"),
            },
            "_request_count": 0,
        }
        api.stages[stage["stageName"]] = stage
        return _json_response(stage, 201)

    async def _get_stage(self, rest_api_id: str, stage_name: str) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        stage = api.stages.get(stage_name)
        if stage is None:
            return _not_found("Stage", stage_name)
        return _json_response(stage)

    async def _update_stage(self, rest_api_id: str, stage_name: str, request: Request) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        stage = api.stages.get(stage_name)
        if stage is None:
            return _not_found("Stage", stage_name)
        body = await parse_json_body(request)
        for op in body.get("patchOperations", []):
            apply_stage_patch_op(stage, op)
        stage["lastUpdatedDate"] = time.time()
        return _json_response(stage)

    async def _delete_stage(self, rest_api_id: str, stage_name: str) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is not None:
            api.stages.pop(stage_name, None)
        return Response(status_code=202)

    # Authorizer, deployment-delete, and method-update handlers are inherited
    # from _ApiGatewayAuthorizerMixin.
