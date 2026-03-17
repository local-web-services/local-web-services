"""Proxy helper functions for API Gateway V2 Lambda invocation."""

from __future__ import annotations

import base64
import json
import re
import time
import uuid
from typing import TYPE_CHECKING, Any

from fastapi import Request, Response

from lws.providers._shared.request_helpers import is_binary_content_type
from lws.providers.apigateway._apigateway_state import _ACCOUNT_ID, _HttpApi

if TYPE_CHECKING:
    pass


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
    is_base64_encoded: bool = False,
) -> dict[str, Any]:
    """Build an API Gateway V2 HTTP API event."""
    # V2 uses comma-joined values for duplicate header names
    headers: dict[str, str] = {}
    for k, v in request.headers.raw:
        key = k.decode("latin-1")
        if key in headers:
            headers[key] += f",{v.decode('latin-1')}"
        else:
            headers[key] = v.decode("latin-1")

    # V2 uses comma-joined values for duplicate query string params
    query_params: dict[str, str] = {}
    for k, v in request.query_params.multi_items():
        if k in query_params:
            query_params[k] += f",{v}"
        else:
            query_params[k] = v

    event: dict[str, Any] = {
        "version": "2.0",
        "routeKey": route_key,
        "rawPath": path,
        "rawQueryString": str(request.url.query) if request.url.query else "",
        "headers": headers,
        "queryStringParameters": query_params if query_params else None,
        "body": body or None,
        "isBase64Encoded": is_base64_encoded,
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
        return Response(
            content=json.dumps({}),
            status_code=200,
            media_type="application/json",
        )

    status_code = payload.get("statusCode", 200)
    resp_headers = payload.get("headers", {})
    resp_body = payload.get("body", "")

    # Decode base64 response body
    is_base64 = payload.get("isBase64Encoded", False)
    if is_base64 and resp_body:
        content = base64.b64decode(resp_body)
    else:
        content = resp_body if isinstance(resp_body, str) else json.dumps(resp_body)

    response = Response(
        content=content,
        status_code=status_code,
        media_type=resp_headers.get(
            "content-type", resp_headers.get("Content-Type", "application/json")
        ),
    )
    for k, v in resp_headers.items():
        if k.lower() != "content-type":
            response.headers[k] = str(v)

    # Support cookies field in V2 Lambda response (set-cookie headers)
    cookies = payload.get("cookies") or []
    for cookie in cookies:
        response.headers.append("set-cookie", cookie)

    return response


async def _encode_request_body(request: Request) -> tuple[str, bool]:
    """Read the request body and return (encoded_str, is_base64)."""
    body_bytes = await request.body()
    content_type = request.headers.get("content-type", "")
    if body_bytes and is_binary_content_type(content_type):
        return base64.b64encode(body_bytes).decode("ascii"), True
    return (body_bytes.decode("utf-8") if body_bytes else ""), False


def _inject_cors_headers(response: Response, api: _HttpApi, request: Request) -> None:
    """Add CORS headers to a proxy response if the API has CORS configured."""
    if api.cors_configuration:
        origin = request.headers.get("origin", "*")
        for k, v in _build_cors_headers(api.cors_configuration, origin).items():
            response.headers[k] = v


def _build_cors_headers(cors: dict[str, Any], origin: str) -> dict[str, str]:
    """Build CORS response headers from a CORS configuration dict."""
    headers: dict[str, str] = {}
    allowed = cors.get("allowOrigins", ["*"])
    if "*" in allowed or origin in allowed:
        headers["access-control-allow-origin"] = origin if "*" not in allowed else "*"
    if cors.get("allowMethods"):
        headers["access-control-allow-methods"] = ",".join(cors["allowMethods"])
    if cors.get("allowHeaders"):
        headers["access-control-allow-headers"] = ",".join(cors["allowHeaders"])
    if cors.get("exposeHeaders"):
        headers["access-control-expose-headers"] = ",".join(cors["exposeHeaders"])
    if cors.get("maxAge") is not None:
        headers["access-control-max-age"] = str(cors["maxAge"])
    if cors.get("allowCredentials"):
        headers["access-control-allow-credentials"] = "true"
    return headers
