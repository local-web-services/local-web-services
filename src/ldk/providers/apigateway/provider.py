"""API Gateway provider - FastAPI HTTP server that proxies to Lambda compute."""

from __future__ import annotations

import asyncio
import json
import uuid
from dataclasses import dataclass

import uvicorn
from fastapi import FastAPI, Request
from fastapi.responses import Response

from ldk.interfaces import ICompute, InvocationResult, LambdaContext, ProviderStatus
from ldk.interfaces.provider import Provider
from ldk.logging.logger import get_logger
from ldk.logging.middleware import RequestLoggingMiddleware

_logger = get_logger("ldk.apigateway")


@dataclass
class RouteConfig:
    """Describes a single API Gateway route.

    Attributes:
        method: HTTP method (GET, POST, PUT, DELETE, etc.).
        path: URL path pattern, e.g. ``/orders/{id}``.
        handler_name: Key into the ``compute_providers`` map that identifies
            which ICompute instance handles this route.
    """

    method: str  # GET, POST, PUT, DELETE, etc.
    path: str  # /orders/{id}
    handler_name: str


def build_proxy_event(request: Request, route: RouteConfig) -> dict:
    """Transform a FastAPI Request into an API Gateway V1 proxy integration event.

    Args:
        request: The incoming FastAPI/Starlette request.
        route: The matched RouteConfig (used for ``resource``).

    Returns:
        A dictionary matching the API Gateway V1 proxy integration event shape.
    """
    path_params = dict(request.path_params) if request.path_params else None
    query_params = dict(request.query_params) if request.query_params else None
    headers = dict(request.headers) if request.headers else {}

    return {
        "httpMethod": request.method,
        "path": request.url.path,
        "pathParameters": path_params,
        "queryStringParameters": query_params,
        "headers": headers,
        "body": None,  # will be set by caller after awaiting body
        "isBase64Encoded": False,
        "requestContext": {
            "httpMethod": request.method,
            "path": request.url.path,
            "requestId": str(uuid.uuid4()),
            "stage": "local",
        },
        "resource": route.path,
    }


def build_http_response(invocation_result: InvocationResult) -> Response:
    """Transform a Lambda InvocationResult into a FastAPI Response.

    If the invocation errored, a 500 response is returned.  Otherwise the
    ``statusCode``, ``headers``, and ``body`` from the Lambda payload are
    forwarded as-is.

    Args:
        invocation_result: The result returned by ``ICompute.invoke``.

    Returns:
        A ``fastapi.responses.Response`` suitable for returning from a route.
    """
    if invocation_result.error is not None:
        return Response(
            content=json.dumps({"error": invocation_result.error}),
            status_code=500,
            media_type="application/json",
        )

    payload = invocation_result.payload or {}
    status_code = payload.get("statusCode", 200)
    resp_headers = payload.get("headers") or {}
    body = payload.get("body", "")

    return Response(
        content=body,
        status_code=status_code,
        headers=resp_headers,
    )


class ApiGatewayProvider(Provider):
    """Provider that exposes Lambda functions behind a local FastAPI HTTP server.

    For every configured route the provider creates a FastAPI endpoint that:
    1. Transforms the HTTP request into an API Gateway V1 proxy event.
    2. Invokes the corresponding ``ICompute`` provider.
    3. Transforms the Lambda response back into an HTTP response.
    """

    def __init__(
        self,
        routes: list[RouteConfig],
        compute_providers: dict[str, ICompute],
        port: int = 3000,
    ) -> None:
        self._routes = routes
        self._compute_providers = compute_providers
        self._port = port
        self._status = ProviderStatus.STOPPED
        self._server: uvicorn.Server | None = None
        self._serve_task: asyncio.Task | None = None  # type: ignore[type-arg]
        self._app = self._build_app()

    # -- Provider lifecycle ---------------------------------------------------

    @property
    def name(self) -> str:
        """Return the unique name of this provider."""
        return "api-gateway"

    @property
    def app(self) -> FastAPI:
        """Return the internal FastAPI application (useful for testing)."""
        return self._app

    async def start(self) -> None:
        """Start the uvicorn server in a background asyncio task."""
        config = uvicorn.Config(
            app=self._app,
            host="0.0.0.0",
            port=self._port,
            log_level="warning",
        )
        self._server = uvicorn.Server(config)
        self._serve_task = asyncio.create_task(self._server.serve())
        # Wait for the server to actually bind before reporting as running
        for _ in range(50):
            if self._server.started:
                break
            await asyncio.sleep(0.1)
        self._status = ProviderStatus.RUNNING

    async def stop(self) -> None:
        """Signal uvicorn to shut down and wait for the task to finish."""
        if self._server is not None:
            self._server.should_exit = True
        if self._serve_task is not None:
            await self._serve_task
            self._serve_task = None
        self._server = None
        self._status = ProviderStatus.STOPPED

    async def health_check(self) -> bool:
        """Return True when the provider status is RUNNING."""
        return self._status is ProviderStatus.RUNNING

    # -- Internal helpers -----------------------------------------------------

    def _build_app(self) -> FastAPI:
        """Create a FastAPI application and register all configured routes."""
        app = FastAPI(title="LDK API Gateway")
        app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="apigateway")

        for route in self._routes:
            self._register_route(app, route)

        return app

    def _register_route(self, app: FastAPI, route: RouteConfig) -> None:
        """Register a single route on the FastAPI app.

        A closure captures the ``route`` and ``compute_provider`` so each
        endpoint knows which Lambda to invoke.
        """
        compute_provider = self._compute_providers[route.handler_name]

        async def _handler(request: Request) -> Response:
            event = build_proxy_event(request, route)

            # Read the body (if any) and attach it to the event.
            raw_body = await request.body()
            event["body"] = raw_body.decode("utf-8") if raw_body else None

            context = LambdaContext(
                function_name=route.handler_name,
                memory_limit_in_mb=128,
                timeout_seconds=30,
                aws_request_id=event["requestContext"]["requestId"],
                invoked_function_arn=(
                    f"arn:aws:lambda:us-east-1:000000000000:function:{route.handler_name}"
                ),
            )

            result = await compute_provider.invoke(event, context)
            return build_http_response(result)

        app.add_api_route(
            path=route.path,
            endpoint=_handler,
            methods=[route.method],
        )
