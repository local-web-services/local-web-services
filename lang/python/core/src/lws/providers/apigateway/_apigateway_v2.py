"""V2 HTTP API management route handlers and proxy for API Gateway."""

from __future__ import annotations

from typing import TYPE_CHECKING, Any

from fastapi import APIRouter, Request, Response

from lws.logging.logger import get_logger
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.lambda_helpers import build_default_lambda_context
from lws.providers._shared.request_helpers import parse_json_body
from lws.providers.apigateway._apigateway_proxy_helpers import (
    _build_apigw_v2_event,
    _build_cors_headers,
    _build_proxy_response,
    _encode_request_body,
    _extract_function_name,
    _extract_path_parameters,
    _inject_cors_headers,
    _route_path_matches,
)
from lws.providers.apigateway._apigateway_state import (
    _ApiGatewayV2State,
    _HttpApi,
    _json_response,
    _not_found,
)
from lws.providers.apigateway._apigateway_v2_routes import ApiGatewayV2SubRouter

if TYPE_CHECKING:
    from lws.providers.lambda_runtime.routes import LambdaRegistry

_logger = get_logger("ldk.apigateway-mgmt")


def _format_http_api(api: _HttpApi) -> dict[str, Any]:
    result: dict[str, Any] = {
        "apiId": api.api_id,
        "name": api.name,
        "protocolType": api.protocol_type,
        "description": api.description,
        "createdDate": api.created_date,
        "apiEndpoint": f"http://localhost/{api.api_id}",
    }
    if api.cors_configuration:
        result["corsConfiguration"] = api.cors_configuration
    return result


class ApiGatewayV2Router:
    """Route API Gateway V2 (HTTP API) management requests."""

    def __init__(
        self,
        lambda_registry: LambdaRegistry | None = None,
        lifecycle: ResourceLifecycleConfig | None = None,
    ) -> None:
        self._state = _ApiGatewayV2State()
        self._lambda_registry = lambda_registry
        self._lifecycle = lifecycle or ResourceLifecycleConfig()
        self._tracker = ResourceStateTracker(self._lifecycle)
        self.router = APIRouter()
        self._sub_router = ApiGatewayV2SubRouter(self._state)
        self._register_routes()

    def _get_lifecycle_error(self, api_id: str) -> Response | None:
        """Return a JSON error response if the HTTP API is in a transient lifecycle state."""
        status = self._tracker.get_state(api_id)
        if status == "CREATING":
            return _json_response(
                {"message": f"HTTP API '{api_id}' is not yet ACTIVE"},
                status_code=409,
            )
        if status == "DELETING":
            return _not_found("Api", api_id)
        return None

    @property
    def state(self) -> _ApiGatewayV2State:
        """Return the V2 API state."""
        return self._state

    def _register_routes(self) -> None:
        r = self.router

        # APIs
        r.add_api_route("/v2/apis", self._create_api, methods=["POST"])
        r.add_api_route("/v2/apis", self._list_apis, methods=["GET"])
        r.add_api_route("/v2/apis/{api_id}", self._get_api, methods=["GET"])
        r.add_api_route("/v2/apis/{api_id}", self._update_api, methods=["PATCH"])
        r.add_api_route("/v2/apis/{api_id}", self._delete_api, methods=["DELETE"])

        # Delegate all sub-resource routes
        self._sub_router.register_sub_routes(r)

    # -- APIs ----------------------------------------------------------------

    async def _create_api(self, request: Request) -> Response:
        body = await parse_json_body(request)
        name = body.get("name", body.get("Name", ""))
        protocol_type = body.get("protocolType", body.get("ProtocolType", "HTTP"))
        description = body.get("description", body.get("Description", ""))
        api = self._state.create_api(name, protocol_type, description)
        cors = body.get("corsConfiguration", body.get("CorsConfiguration"))
        if cors:
            api.cors_configuration = cors
        _logger.info("V2 CreateApi: name=%s id=%s", name, api.api_id)
        # Lifecycle: set CREATING status if dwell time configured
        if self._lifecycle.enabled and self._lifecycle.create_dwell_ms > 0:
            self._tracker.set_state(api.api_id, "CREATING")
            self._tracker.schedule_transition(api.api_id, "ACTIVE", self._lifecycle.create_dwell_ms)
        return _json_response(_format_http_api(api), 201)

    async def _list_apis(self, _request: Request) -> Response:
        apis = self._state.list_apis()
        return _json_response({"items": [_format_http_api(a) for a in apis]})

    async def _get_api(self, api_id: str) -> Response:
        err = self._get_lifecycle_error(api_id)
        if err is not None:
            return err
        api = self._state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        return _json_response(_format_http_api(api))

    async def _update_api(self, api_id: str, request: Request) -> Response:
        err = self._get_lifecycle_error(api_id)
        if err is not None:
            return err
        api = self._state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        body = await parse_json_body(request)
        if "name" in body or "Name" in body:
            api.name = body.get("name", body.get("Name", api.name))
        if "description" in body or "Description" in body:
            api.description = body.get("description", body.get("Description", api.description))
        cors = body.get("corsConfiguration", body.get("CorsConfiguration"))
        if cors:
            api.cors_configuration = cors
        return _json_response(_format_http_api(api))

    async def _delete_api(self, api_id: str) -> Response:
        # Block deletion if the HTTP API is still CREATING
        status = self._tracker.get_state(api_id)
        if status == "CREATING":
            return _json_response(
                {"message": f"HTTP API '{api_id}' is not yet ACTIVE"},
                status_code=409,
            )
        self._state.delete_api(api_id)
        # Lifecycle: set DELETING status if dwell time configured
        if self._lifecycle.enabled and self._lifecycle.delete_dwell_ms > 0:
            self._tracker.set_state(api_id, "DELETING")
            self._tracker.schedule_transition(api_id, None, self._lifecycle.delete_dwell_ms)
        else:
            self._tracker.remove(api_id)
        return Response(status_code=204)

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

    def _find_api_for_path(self, path: str) -> _HttpApi | None:
        """Find a V2 API with CORS config whose routes match *path*."""
        for api in self._state.list_apis():
            if not api.cors_configuration:
                continue
            for route in api.routes.values():
                route_key = route.get("routeKey", "")
                if route_key == "$default":
                    return api
                parts = route_key.split(" ", 1)
                if len(parts) == 2 and _route_path_matches(parts[1], path):
                    return api
        return None

    async def handle_cors_preflight(self, request: Request, path: str) -> Response | None:
        """Handle OPTIONS preflight if a V2 API has CORS configured."""
        request_path = f"/{path}" if not path.startswith("/") else path
        api = self._find_api_for_path(request_path)
        if api is None or api.cors_configuration is None:
            return None
        origin = request.headers.get("origin", "*")
        cors_headers = _build_cors_headers(api.cors_configuration, origin)
        return Response(status_code=204, headers=cors_headers)

    def _resolve_compute(self, integration: dict[str, Any]):
        """Resolve the ICompute from an integration, or return None."""
        integration_uri = integration.get("integrationUri", "")
        function_name = _extract_function_name(integration_uri)
        if not function_name or self._lambda_registry is None:
            return None, None
        compute = self._lambda_registry.get_compute(function_name)
        return function_name, compute

    async def proxy_request(self, request: Request, path: str) -> Response | None:
        """Try to proxy a request through V2 routes. Returns None if no match."""
        method = request.method
        request_path = f"/{path}" if not path.startswith("/") else path

        _logger.info(
            "V2 proxy: trying %s %s (apis=%d)",
            method,
            request_path,
            len(self._state.list_apis()),
        )

        if method == "OPTIONS":
            return await self.handle_cors_preflight(request, path)

        match = self._find_matching_route(method, request_path)
        if match is None:
            return None

        _api, route, integration = match
        function_name, compute = self._resolve_compute(integration)
        if compute is None:
            return None

        body_str, is_base64 = await _encode_request_body(request)
        route_key = route.get("routeKey", "")
        route_path = route_key.split(" ", 1)[-1] if " " in route_key else ""
        path_params = _extract_path_parameters(route_path, request_path)

        event = _build_apigw_v2_event(
            request, request_path, body_str, route_key, path_params, is_base64
        )
        context = build_default_lambda_context(function_name)
        result = await compute.invoke(event, context)

        if result.error:
            return _json_response({"message": result.error}, 502)

        response = _build_proxy_response(result.payload)
        _inject_cors_headers(response, _api, request)
        return response
