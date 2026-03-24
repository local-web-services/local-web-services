"""V1 REST API management route handlers for API Gateway."""

from __future__ import annotations

import json as _json
from typing import Any

from fastapi import APIRouter, Request, Response

from lws.logging.logger import get_logger
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.request_helpers import parse_json_body
from lws.providers.apigateway._apigateway_state import (
    _ApiGatewayState,
    _json_response,
    _not_found,
    _RestApi,
)
from lws.providers.apigateway._apigateway_v1_dispatch import (
    _dispatch_integration,
    _parse_integration_uri,
)
from lws.providers.apigateway._apigateway_v1_resources import ApiGatewayResourceRouter

_log = get_logger("ldk.apigateway-v1-proxy")


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


class ApiGatewayManagementRouter:
    """Route API Gateway management requests to the in-memory state."""

    def __init__(self, lifecycle: ResourceLifecycleConfig | None = None) -> None:
        self._state = _ApiGatewayState()
        self._lifecycle = lifecycle or ResourceLifecycleConfig()
        self._tracker = ResourceStateTracker(self._lifecycle)
        self.router = APIRouter()
        self._resource_router = ApiGatewayResourceRouter(self._state)
        self._service_providers: dict[str, Any] = {}
        self._register_routes()

    def _get_lifecycle_error(self, api_id: str) -> Response | None:
        """Return a JSON error response if the REST API is in a transient lifecycle state."""
        status = self._tracker.get_state(api_id)
        if status == "CREATING":
            return _json_response(
                {"message": f"REST API '{api_id}' is not yet ACTIVE"},
                status_code=409,
            )
        if status == "DELETING":
            return _not_found("RestApi", api_id)
        return None

    def set_service_providers(self, providers: dict[str, Any]) -> None:
        """Register backend service providers for V1 integration dispatch."""
        self._service_providers = providers
        self._resource_router.set_service_providers(providers)

    def reset(self) -> None:
        """Clear all REST API state and cancel pending lifecycle transitions."""
        self._state.reset()
        self._tracker.reset()

    def _resolve_v1_route(self, path: str) -> tuple[str, str, str] | None:
        """Parse a V1 proxy path into (rest_api_id, stage_name, resource_path).

        Returns ``None`` when the path is too short to be a valid V1 URL.
        """
        parts = path.strip("/").split("/", 2)
        if len(parts) < 2:
            return None
        rest_api_id = parts[0]
        stage_name = parts[1]
        resource_path = f"/{parts[2]}" if len(parts) > 2 else "/"
        return rest_api_id, stage_name, resource_path

    def _resolve_v1_integration(
        self, method_config: dict | None
    ) -> tuple[dict | None, Response | None]:
        """Return (service_descriptor, error_response) for a V1 integration.

        Returns ``(descriptor, None)`` on success or ``(None, error_response)``
        when the integration is missing or unsupported.
        """
        integration = (method_config or {}).get("methodIntegration")
        if integration is None or integration.get("type") != "AWS":
            return None, _json_response(
                {"message": "lws: No AWS integration configured for this method"},
                status_code=500,
            )
        uri = integration.get("uri", "")
        service_descriptor = _parse_integration_uri(uri)
        if service_descriptor is None:
            return None, _json_response(
                {"message": f"lws: Unsupported integration URI: {uri}"},
                status_code=500,
            )
        return service_descriptor, None

    async def _parse_request_body(self, request: Request) -> dict:
        """Read and JSON-decode the request body; return empty dict on failure."""
        try:
            body_bytes = await request.body()
            return _json.loads(body_bytes) if body_bytes else {}
        except (ValueError, UnicodeDecodeError):
            return {}

    async def _run_integration(
        self, service_descriptor: dict, request_body: dict
    ) -> tuple[dict | None, Response | None]:
        """Call _dispatch_integration and wrap errors as error responses.

        Returns ``(result, None)`` on success or ``(None, error_response)`` on failure.
        """
        try:
            result = await _dispatch_integration(
                service_descriptor, request_body, self._service_providers
            )
            return result, None
        except ValueError as exc:
            _log.error("Integration dispatch failed: %s", exc)
            return None, _json_response(
                {"message": f"lws: Integration error: {exc}"},
                status_code=500,
            )
        except Exception as exc:  # noqa: BLE001
            _log.error("Integration dispatch unexpected error: %s", exc)
            return None, _json_response(
                {"message": f"lws: Internal error: {exc}"},
                status_code=500,
            )

    def _find_v1_method_config(
        self, rest_api_id: str, stage_name: str, resource_path: str, http_method: str
    ) -> tuple[dict | None, Response | None]:
        """Look up the method config for a V1 route; return (config, None) or (None, error).

        Returns ``(None, None)`` when the API or stage is not found (caller should return None).
        """
        api = self._state.get_rest_api(rest_api_id)
        if api is None or stage_name not in api.stages:
            return None, None

        matching_resource = next(
            (r for r in api.resources.values() if r["path"] == resource_path), None
        )
        if matching_resource is None:
            return None, _json_response(
                {"message": f"lws: No resource found for path {resource_path}"},
                status_code=404,
            )

        method_config = matching_resource.get("resourceMethods", {}).get(http_method)
        if method_config is None:
            return None, _json_response(
                {"message": f"lws: No method {http_method} on resource {resource_path}"},
                status_code=405,
            )
        return method_config, None

    async def proxy_v1_request(self, request: Request, path: str) -> Response | None:
        """Try to dispatch an incoming request as a V1 REST API invocation.

        The URL structure for a deployed REST API stage is::

            /{restApiId}/{stageName}/{resourcePath}

        Returns ``None`` when the path does not map to a known V1 deployment
        so the caller can fall through to other handlers.
        """
        route = self._resolve_v1_route(path)
        if route is None:
            return None
        rest_api_id, stage_name, resource_path = route
        http_method = request.method.upper()

        method_config, err = self._find_v1_method_config(
            rest_api_id, stage_name, resource_path, http_method
        )
        if err is not None:
            return err
        if method_config is None:
            return None

        service_descriptor, err = self._resolve_v1_integration(method_config)
        if err is not None:
            return err

        request_body = await self._parse_request_body(request)
        result, err = await self._run_integration(service_descriptor, request_body)
        if err is not None:
            return err

        return Response(
            content=_json.dumps(result, default=str),
            status_code=200,
            media_type="application/json",
        )

    def _register_routes(self) -> None:
        r = self.router

        # REST APIs
        r.add_api_route("/restapis", self._create_rest_api, methods=["POST"])
        r.add_api_route("/restapis", self._list_rest_apis, methods=["GET"])
        r.add_api_route("/restapis/{rest_api_id}", self._get_rest_api, methods=["GET"])
        r.add_api_route("/restapis/{rest_api_id}", self._delete_rest_api, methods=["DELETE"])
        r.add_api_route("/restapis/{rest_api_id}", self._update_rest_api, methods=["PATCH"])

        # Delegate all sub-resource routes
        self._resource_router.register_resource_routes(r)

    # -- REST APIs -----------------------------------------------------------

    async def _create_rest_api(self, request: Request) -> Response:
        body = await parse_json_body(request)
        name = body.get("name", "")
        description = body.get("description", "")
        if self._state.find_by_name(name) is not None:
            return _json_response(
                {"message": f"REST API with name '{name}' already exists"},
                status_code=409,
            )
        api = self._state.create_rest_api(name, description)
        # Lifecycle: set CREATING status if dwell time configured
        if self._lifecycle.enabled and self._lifecycle.create_dwell_ms > 0:
            self._tracker.set_state(api.id, "CREATING")
            self._tracker.schedule_transition(api.id, "ACTIVE", self._lifecycle.create_dwell_ms)
        return _json_response(_format_rest_api(api), 201)

    async def _list_rest_apis(self, _request: Request) -> Response:
        apis = self._state.list_rest_apis()
        return _json_response({"item": [_format_rest_api(a) for a in apis]})

    async def _get_rest_api(self, rest_api_id: str) -> Response:
        err = self._get_lifecycle_error(rest_api_id)
        if err is not None:
            return err
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        return _json_response(_format_rest_api(api))

    async def _update_rest_api(self, rest_api_id: str, request: Request) -> Response:
        err = self._get_lifecycle_error(rest_api_id)
        if err is not None:
            return err
        api = self._state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        body = await parse_json_body(request)
        for op in body.get("patchOperations", []):
            if op.get("path") == "/name" and op.get("op") == "replace":
                api.name = op.get("value", api.name)
            elif op.get("path") == "/description" and op.get("op") == "replace":
                api.description = op.get("value", api.description)
        return _json_response(_format_rest_api(api))

    async def _delete_rest_api(self, rest_api_id: str) -> Response:
        # Block deletion if the REST API is still CREATING
        status = self._tracker.get_state(rest_api_id)
        if status == "CREATING":
            return _json_response(
                {"message": f"REST API '{rest_api_id}' is not yet ACTIVE"},
                status_code=409,
            )
        self._state.delete_rest_api(rest_api_id)
        # Lifecycle: set DELETING status if dwell time configured
        if self._lifecycle.enabled and self._lifecycle.delete_dwell_ms > 0:
            self._tracker.set_state(rest_api_id, "DELETING")
            self._tracker.schedule_transition(rest_api_id, None, self._lifecycle.delete_dwell_ms)
        else:
            self._tracker.remove(rest_api_id)
        return Response(status_code=202)
