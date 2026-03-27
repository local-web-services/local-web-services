"""Authorizer, deployment-delete, and method-update handlers for V1 REST API."""

from __future__ import annotations

import uuid

from fastapi import Request, Response

from lws.providers._shared.request_helpers import parse_json_body
from lws.providers.apigateway._apigateway_state import (
    _ApiGatewayState,
    _json_response,
    _not_found,
)


class _ApiGatewayAuthorizerMixin:
    """Mixin providing authorizer CRUD, deployment delete, and method update handlers.

    Expects ``self._res_state`` (``_ApiGatewayState``) to be set by the host class.
    """

    _res_state: _ApiGatewayState

    def _resolve_method(
        self, rest_api_id: str, resource_id: str, http_method: str
    ) -> tuple[dict | None, Response | None]:
        """Look up method config; return (method_dict, None) or (None, error_response)."""
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return None, _not_found("RestApi", rest_api_id)
        resource = api.resources.get(resource_id)
        if resource is None:
            return None, _not_found("Resource", resource_id)
        method = resource["resourceMethods"].get(http_method)
        if method is None:
            return None, _not_found("Method", http_method)
        return method, None

    # -- Authorizers ---------------------------------------------------------

    async def _create_authorizer(self, rest_api_id: str, request: Request) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        body = await parse_json_body(request)
        authorizer_id = str(uuid.uuid4())[:10]
        authorizer = {
            "id": authorizer_id,
            "name": body.get("name", ""),
            "type": body.get("type", "TOKEN"),
            "providerARNs": body.get("providerARNs", []),
            "authorizerUri": body.get("authorizerUri", ""),
            "identitySource": body.get("identitySource", ""),
        }
        api.authorizers[authorizer_id] = authorizer
        return _json_response(authorizer, 201)

    async def _list_authorizers(self, rest_api_id: str) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        return _json_response({"item": list(api.authorizers.values())})

    async def _get_authorizer(self, rest_api_id: str, authorizer_id: str) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        authorizer = api.authorizers.get(authorizer_id)
        if authorizer is None:
            return _not_found("Authorizer", authorizer_id)
        return _json_response(authorizer)

    async def _update_authorizer(
        self, rest_api_id: str, authorizer_id: str, request: Request
    ) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is None:
            return _not_found("RestApi", rest_api_id)
        authorizer = api.authorizers.get(authorizer_id)
        if authorizer is None:
            return _not_found("Authorizer", authorizer_id)
        body = await parse_json_body(request)
        for op in body.get("patchOperations", []):
            path = op.get("path", "")
            value = op.get("value")
            if op.get("op") == "replace":
                if path == "/name":
                    authorizer["name"] = value
                elif path == "/type":
                    authorizer["type"] = value
                elif path == "/identitySource":
                    authorizer["identitySource"] = value
                elif path == "/authorizerUri":
                    authorizer["authorizerUri"] = value
                elif path == "/providerARNs":
                    authorizer["providerARNs"] = value
        return _json_response(authorizer)

    async def _delete_authorizer(self, rest_api_id: str, authorizer_id: str) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is not None:
            api.authorizers.pop(authorizer_id, None)
        return Response(status_code=202)

    # -- Deployment delete ---------------------------------------------------

    async def _delete_deployment(self, rest_api_id: str, deployment_id: str) -> Response:
        api = self._res_state.get_rest_api(rest_api_id)
        if api is not None:
            api.deployments.pop(deployment_id, None)
        return Response(status_code=202)

    # -- Method update -------------------------------------------------------

    async def _update_method(
        self, rest_api_id: str, resource_id: str, http_method: str, request: Request
    ) -> Response:
        method, err = self._resolve_method(rest_api_id, resource_id, http_method)
        if err is not None:
            return err
        body = await parse_json_body(request)
        for op in body.get("patchOperations", []):
            path = op.get("path", "")
            value = op.get("value")
            if op.get("op") == "replace":
                if path == "/authorizationType":
                    method["authorizationType"] = value
                elif path == "/authorizerId":
                    method["authorizerId"] = value
                elif path == "/apiKeyRequired":
                    method["apiKeyRequired"] = value
        return _json_response(method)
