"""V2 HTTP API route/integration/authorizer/stage CRUD handlers for API Gateway."""

from __future__ import annotations

import uuid

from fastapi import Request, Response

from lws.logging.logger import get_logger
from lws.providers._shared.request_helpers import parse_json_body
from lws.providers.apigateway._apigateway_state import (
    _ApiGatewayV2State,
    _json_response,
    _not_found,
)

_logger = get_logger("ldk.apigateway-mgmt")


class ApiGatewayV2SubRouter:
    """Registers stage/integration/route/authorizer routes for V2 HTTP APIs.

    Expects ``self._v2_state`` (``_ApiGatewayV2State``) to be set by the host class
    before ``register_sub_routes`` is called.
    """

    def __init__(self, state: _ApiGatewayV2State) -> None:
        self._v2_state = state

    def register_sub_routes(self, router) -> None:  # noqa: ANN001
        """Add all sub-API routes to *router*."""
        r = router

        # Stages
        r.add_api_route("/v2/apis/{api_id}/stages", self._create_stage, methods=["POST"])
        r.add_api_route("/v2/apis/{api_id}/stages", self._list_stages, methods=["GET"])
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

        # Authorizers
        r.add_api_route("/v2/apis/{api_id}/authorizers", self._create_authorizer, methods=["POST"])
        r.add_api_route("/v2/apis/{api_id}/authorizers", self._list_authorizers, methods=["GET"])
        r.add_api_route(
            "/v2/apis/{api_id}/authorizers/{authorizer_id}",
            self._get_authorizer,
            methods=["GET"],
        )
        r.add_api_route(
            "/v2/apis/{api_id}/authorizers/{authorizer_id}",
            self._delete_authorizer,
            methods=["DELETE"],
        )

    # -- Stages --------------------------------------------------------------

    async def _create_stage(self, api_id: str, request: Request) -> Response:
        api = self._v2_state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        body = await parse_json_body(request)
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
        api = self._v2_state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        stage = api.stages.get(stage_name)
        if stage is None:
            return _not_found("Stage", stage_name)
        return _json_response(stage)

    async def _update_stage(self, api_id: str, stage_name: str, _request: Request) -> Response:
        api = self._v2_state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        stage = api.stages.get(stage_name)
        if stage is None:
            return _not_found("Stage", stage_name)
        stage["lastUpdatedDate"] = "2024-01-01T00:00:00Z"
        return _json_response(stage)

    async def _delete_stage(self, api_id: str, stage_name: str) -> Response:
        api = self._v2_state.get_api(api_id)
        if api is not None:
            api.stages.pop(stage_name, None)
        return Response(status_code=204)

    async def _list_stages(self, api_id: str) -> Response:
        api = self._v2_state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        return _json_response({"items": list(api.stages.values())})

    # -- Integrations --------------------------------------------------------

    async def _create_integration(self, api_id: str, request: Request) -> Response:
        api = self._v2_state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        body = await parse_json_body(request)
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
        api = self._v2_state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        integration = api.integrations.get(integration_id)
        if integration is None:
            return _not_found("Integration", integration_id)
        return _json_response(integration)

    async def _list_integrations(self, api_id: str) -> Response:
        api = self._v2_state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        return _json_response({"items": list(api.integrations.values())})

    async def _delete_integration(self, api_id: str, integration_id: str) -> Response:
        api = self._v2_state.get_api(api_id)
        if api is not None:
            api.integrations.pop(integration_id, None)
        return Response(status_code=204)

    # -- Routes --------------------------------------------------------------

    async def _create_route(self, api_id: str, request: Request) -> Response:
        api = self._v2_state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        body = await parse_json_body(request)
        route_id = str(uuid.uuid4())[:7]
        route_key = body.get("routeKey", body.get("RouteKey", ""))
        target = body.get("target", body.get("Target", ""))
        auth_type = body.get("authorizationType", body.get("AuthorizationType", "NONE"))
        auth_id = body.get("authorizerId", body.get("AuthorizerId", ""))
        route = {
            "routeId": route_id,
            "routeKey": route_key,
            "target": target,
            "apiId": api_id,
            "authorizationType": auth_type,
            "authorizerId": auth_id,
        }
        api.routes[route_id] = route
        _logger.debug("V2 created route: key=%r target=%r api=%s", route_key, target, api_id)
        return _json_response(route, 201)

    async def _get_route(self, api_id: str, route_id: str) -> Response:
        api = self._v2_state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        route = api.routes.get(route_id)
        if route is None:
            return _not_found("Route", route_id)
        return _json_response(route)

    async def _list_routes(self, api_id: str) -> Response:
        api = self._v2_state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        return _json_response({"items": list(api.routes.values())})

    async def _delete_route(self, api_id: str, route_id: str) -> Response:
        api = self._v2_state.get_api(api_id)
        if api is not None:
            api.routes.pop(route_id, None)
        return Response(status_code=204)

    # -- Authorizers ---------------------------------------------------------

    async def _create_authorizer(self, api_id: str, request: Request) -> Response:
        api = self._v2_state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        body = await parse_json_body(request)
        authorizer_id = str(uuid.uuid4())[:7]
        authorizer = {
            "authorizerId": authorizer_id,
            "name": body.get("name", body.get("Name", "")),
            "authorizerType": body.get("authorizerType", body.get("AuthorizerType", "JWT")),
            "identitySource": body.get("identitySource", body.get("IdentitySource", "")),
            "jwtConfiguration": body.get("jwtConfiguration", body.get("JwtConfiguration", {})),
            "apiId": api_id,
        }
        api.authorizers[authorizer_id] = authorizer
        return _json_response(authorizer, 201)

    async def _list_authorizers(self, api_id: str) -> Response:
        api = self._v2_state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        return _json_response({"items": list(api.authorizers.values())})

    async def _get_authorizer(self, api_id: str, authorizer_id: str) -> Response:
        api = self._v2_state.get_api(api_id)
        if api is None:
            return _not_found("Api", api_id)
        authorizer = api.authorizers.get(authorizer_id)
        if authorizer is None:
            return _not_found("Authorizer", authorizer_id)
        return _json_response(authorizer)

    async def _delete_authorizer(self, api_id: str, authorizer_id: str) -> Response:
        api = self._v2_state.get_api(api_id)
        if api is not None:
            api.authorizers.pop(authorizer_id, None)
        return Response(status_code=204)
