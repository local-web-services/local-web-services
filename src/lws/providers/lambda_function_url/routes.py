"""Lambda Function URL HTTP routes.

Creates a FastAPI app that emulates an AWS Lambda Function URL endpoint.
Incoming HTTP requests are converted to payload format version 2.0 events,
forwarded to the Lambda compute provider, and the response is converted
back to HTTP.
"""

from __future__ import annotations

import base64
import json
import time
import uuid
from typing import Any

from fastapi import FastAPI, Request, Response
from fastapi.responses import JSONResponse

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.lambda_helpers import build_default_lambda_context

_logger = get_logger("ldk.function-url")


# ---------------------------------------------------------------------------
# Event builder — payload format version 2.0
# ---------------------------------------------------------------------------


def build_function_url_event(request: Request, body: bytes) -> dict[str, Any]:
    """Build a Lambda Function URL event (payload format version 2.0)."""
    url_id = uuid.uuid4().hex[:12]
    now = time.time()
    path = request.url.path or "/"
    query_string = str(request.query_params) if request.query_params else ""

    # Headers — lowercase keys, single-value
    headers: dict[str, str] = {}
    for key, value in request.headers.items():
        headers[key.lower()] = value

    # Query string parameters
    query_params: dict[str, str] | None = None
    if request.query_params:
        query_params = dict(request.query_params)

    # Body handling
    body_str: str | None = None
    is_base64 = False
    if body:
        try:
            body_str = body.decode("utf-8")
        except UnicodeDecodeError:
            body_str = base64.b64encode(body).decode("ascii")
            is_base64 = True

    event: dict[str, Any] = {
        "version": "2.0",
        "routeKey": "$default",
        "rawPath": path,
        "rawQueryString": query_string,
        "headers": headers,
        "requestContext": {
            "accountId": "000000000000",
            "apiId": url_id,
            "domainName": "localhost",
            "domainPrefix": url_id,
            "http": {
                "method": request.method,
                "path": path,
                "protocol": f"HTTP/{request.scope.get('http_version', '1.1')}",
                "sourceIp": request.client.host if request.client else "127.0.0.1",
                "userAgent": headers.get("user-agent", ""),
            },
            "requestId": str(uuid.uuid4()),
            "routeKey": "$default",
            "stage": "$default",
            "time": time.strftime("%d/%b/%Y:%H:%M:%S +0000", time.gmtime(now)),
            "timeEpoch": int(now * 1000),
        },
        "isBase64Encoded": is_base64,
    }

    if body_str is not None:
        event["body"] = body_str
    if query_params:
        event["queryStringParameters"] = query_params

    return event


# ---------------------------------------------------------------------------
# Response builder
# ---------------------------------------------------------------------------


def build_http_response(lambda_result: dict[str, Any] | str | None) -> Response:
    """Convert a Lambda response to an HTTP response.

    Handles both structured responses (with statusCode, headers, body) and
    simple string/dict responses.
    """
    if lambda_result is None:
        return Response(status_code=200, content="")

    # Simple string response
    if isinstance(lambda_result, str):
        return Response(
            status_code=200,
            content=lambda_result,
            media_type="application/json",
        )

    # Structured response
    status_code = int(lambda_result.get("statusCode", 200))
    resp_headers = lambda_result.get("headers") or {}
    body = lambda_result.get("body", "")
    is_base64 = lambda_result.get("isBase64Encoded", False)

    if is_base64 and isinstance(body, str):
        content = base64.b64decode(body)
    elif isinstance(body, (dict, list)):
        content = json.dumps(body).encode("utf-8")
        if "content-type" not in {k.lower() for k in resp_headers}:
            resp_headers["content-type"] = "application/json"
    else:
        content = body.encode("utf-8") if isinstance(body, str) else body

    # Handle cookies
    cookies = lambda_result.get("cookies") or []

    response = Response(status_code=status_code, content=content)
    for key, value in resp_headers.items():
        response.headers[key] = str(value)
    for cookie in cookies:
        response.headers.append("set-cookie", cookie)

    return response


# ---------------------------------------------------------------------------
# CORS helpers
# ---------------------------------------------------------------------------


def apply_cors_headers(
    response: Response,
    cors_config: dict[str, Any],
    origin: str | None = None,
) -> None:
    """Apply CORS headers to a response based on the Function URL CORS config."""
    allow_origins = cors_config.get("AllowOrigins", [])
    allow_methods = cors_config.get("AllowMethods", [])
    allow_headers = cors_config.get("AllowHeaders", [])
    expose_headers = cors_config.get("ExposeHeaders", [])
    max_age = cors_config.get("MaxAge")
    allow_credentials = cors_config.get("AllowCredentials", False)

    if allow_origins:
        if "*" in allow_origins:
            response.headers["access-control-allow-origin"] = "*"
        elif origin and origin in allow_origins:
            response.headers["access-control-allow-origin"] = origin
        elif allow_origins:
            response.headers["access-control-allow-origin"] = allow_origins[0]

    if allow_methods:
        response.headers["access-control-allow-methods"] = ", ".join(allow_methods)
    if allow_headers:
        response.headers["access-control-allow-headers"] = ", ".join(allow_headers)
    if expose_headers:
        response.headers["access-control-expose-headers"] = ", ".join(expose_headers)
    if max_age is not None:
        response.headers["access-control-max-age"] = str(max_age)
    if allow_credentials:
        response.headers["access-control-allow-credentials"] = "true"


def build_cors_preflight_response(
    cors_config: dict[str, Any], origin: str | None = None
) -> Response:
    """Build a CORS preflight (OPTIONS) response."""
    response = Response(status_code=204)
    apply_cors_headers(response, cors_config, origin)
    return response


# ---------------------------------------------------------------------------
# App factory
# ---------------------------------------------------------------------------


def create_lambda_function_url_app(
    function_name: str,
    compute: Any,
    cors_config: dict[str, Any] | None = None,
) -> FastAPI:
    """Create a FastAPI app that serves a Lambda Function URL endpoint."""
    app = FastAPI(title=f"Function URL: {function_name}")
    app.add_middleware(
        RequestLoggingMiddleware,
        logger=_logger,
        service_name=f"function-url:{function_name}",
    )

    async def _handle_request(request: Request) -> Response:
        # CORS preflight
        if request.method == "OPTIONS" and cors_config:
            origin = request.headers.get("origin")
            return build_cors_preflight_response(cors_config, origin)

        body = await request.body()
        event = build_function_url_event(request, body)
        context = build_default_lambda_context(function_name)

        result = await compute.invoke(event, context)

        if result.error:
            response = JSONResponse(
                status_code=502,
                content={"errorMessage": result.error},
            )
        else:
            response = build_http_response(result.payload)

        # Apply CORS headers if configured
        if cors_config:
            origin = request.headers.get("origin")
            apply_cors_headers(response, cors_config, origin)

        return response

    app.add_api_route(
        "/{path:path}",
        _handle_request,
        methods=["GET", "POST", "PUT", "PATCH", "DELETE", "HEAD", "OPTIONS"],
    )
    # Also handle root path
    app.add_api_route(
        "/",
        _handle_request,
        methods=["GET", "POST", "PUT", "PATCH", "DELETE", "HEAD", "OPTIONS"],
    )

    return app
