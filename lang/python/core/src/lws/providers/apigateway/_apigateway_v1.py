"""V1 REST API management route handlers for API Gateway."""

from __future__ import annotations

from typing import Any

from fastapi import APIRouter, Request, Response

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.request_helpers import parse_json_body
from lws.providers.apigateway._apigateway_state import (
    _ApiGatewayState,
    _RestApi,
    _json_response,
    _not_found,
)
from lws.providers.apigateway._apigateway_v1_resources import ApiGatewayResourceRouter


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
