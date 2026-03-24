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
from typing import TYPE_CHECKING

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig
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
    _ACCOUNT_ID,
    _REGION,
    _ApiGatewayState,
    _ApiGatewayV2State,
    _HttpApi,
    _RestApi,
)
from lws.providers.apigateway._apigateway_v1 import ApiGatewayManagementRouter
from lws.providers.apigateway._apigateway_v2 import ApiGatewayV2Router, _format_http_api

if TYPE_CHECKING:
    from lws.providers.lambda_runtime.routes import LambdaRegistry

_logger = get_logger("ldk.apigateway-mgmt")

# Re-export everything that external code may have imported from this module.
__all__ = [
    "_ACCOUNT_ID",
    "_REGION",
    "_ApiGatewayState",
    "_ApiGatewayV2State",
    "_HttpApi",
    "_RestApi",
    "_build_apigw_v2_event",
    "_build_cors_headers",
    "_build_proxy_response",
    "_encode_request_body",
    "_extract_function_name",
    "_extract_path_parameters",
    "_format_http_api",
    "_inject_cors_headers",
    "_route_path_matches",
    "ApiGatewayManagementRouter",
    "ApiGatewayV2Router",
    "ApiGatewayRouterBundle",
    "create_apigateway_management_app",
]


def _json_response(data: dict, status_code: int = 200) -> Response:
    return Response(
        content=json.dumps(data, default=str),
        status_code=status_code,
        media_type="application/json",
    )


# ---------------------------------------------------------------------------
# App factory
# ---------------------------------------------------------------------------


class ApiGatewayRouterBundle:
    """Holds the V1 and V2 routers so callers can reset both together."""

    def __init__(
        self,
        v1_router: ApiGatewayManagementRouter,
        v2_router: ApiGatewayV2Router,
    ) -> None:
        self._v1 = v1_router
        self._v2 = v2_router

    def reset(self) -> None:
        """Clear all API Gateway state and cancel pending lifecycle transitions."""
        self._v1.reset()
        self._v2.reset()

    def set_service_providers(self, providers: dict) -> None:  # noqa: ANN001
        """Wire backend service providers into V1 integration dispatch."""
        self._v1.set_service_providers(providers)


def create_apigateway_management_app(
    lambda_registry: LambdaRegistry | None = None,
    lifecycle: ResourceLifecycleConfig | None = None,
    service_providers: dict | None = None,
) -> tuple[FastAPI, ApiGatewayRouterBundle]:
    """Create a FastAPI app that speaks the API Gateway management protocol.

    Args:
        lambda_registry: Optional shared registry for Lambda compute providers.
            When provided, V2 routes and proxy invocation are enabled.
        lifecycle: Optional lifecycle simulation config. When provided with
            ``create_dwell_ms > 0``, newly created REST APIs and HTTP APIs will
            transition through CREATING before becoming ACTIVE.
        service_providers: Optional map of service-name → provider instance.
            When provided, V1 REST API direct service integrations (DynamoDB,
            SQS, SNS, S3, StepFunctions) will be dispatched to these providers.

    Returns:
        A tuple of (app, router_bundle). Call ``router_bundle.reset()`` to
        clear all API Gateway state between tests.
    """
    app = FastAPI(title="LDK API Gateway Management")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="apigateway-mgmt")

    # V1 management routes
    v1_router = ApiGatewayManagementRouter(lifecycle=lifecycle)
    if service_providers:
        v1_router.set_service_providers(service_providers)

    # V2 management routes (+ proxy)
    v2_router = ApiGatewayV2Router(lambda_registry=lambda_registry, lifecycle=lifecycle)

    # Include V2 first so /v2/... paths match before the V1 catch-all
    app.include_router(v2_router.router)
    app.include_router(v1_router.router)

    # Wire V2 proxy into the catch-all: override the V1 stub to also try V2 proxy
    @app.api_route("/{path:path}", methods=["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"])
    async def _catch_all_with_proxy(request: Request, path: str) -> Response:
        # Try V1 REST API direct integration proxy first
        v1_resp = await v1_router.proxy_v1_request(request, path)
        if v1_resp is not None:
            return v1_resp
        # Try V2 proxy next
        if lambda_registry is not None:
            proxy_resp = await v2_router.proxy_request(request, path)
            if proxy_resp is not None:
                return proxy_resp
        # Fall back to stub — include diagnostic info
        v2_apis = v2_router.state.list_apis()
        v2_route_count = sum(len(a.routes) for a in v2_apis)
        reg_funcs = list(lambda_registry.functions.keys()) if lambda_registry else []
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

    bundle = ApiGatewayRouterBundle(v1_router, v2_router)
    return app, bundle
