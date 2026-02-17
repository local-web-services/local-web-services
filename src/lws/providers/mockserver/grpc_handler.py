"""gRPC generic service handler for mock servers.

Uses ``grpc.aio.server`` with a ``GenericRpcHandler`` that matches
incoming RPCs to DSL-defined mock responses.
"""

from __future__ import annotations

import json
import logging
from typing import Any

from lws.providers.mockserver.models import GrpcRoute
from lws.providers.mockserver.operators import match_value
from lws.providers.mockserver.template import render_template

logger = logging.getLogger(__name__)


def match_grpc_request(
    routes: list[GrpcRoute],
    service: str,
    method: str,
    request_fields: dict[str, Any],
) -> dict[str, Any] | None:
    """Match a gRPC request against configured routes.

    Returns the matched response dict or None.
    """
    for route in routes:
        if route.service != service or route.method != method:
            continue

        match_spec = route.match
        if not match_spec:
            return _render_grpc_response(route.response, request_fields)

        field_matchers = match_spec.get("fields", {})
        if field_matchers and not _match_fields(field_matchers, request_fields):
            continue

        return _render_grpc_response(route.response, request_fields)

    return None


def _match_fields(matchers: dict[str, Any], fields: dict[str, Any]) -> bool:
    """Check if request fields match the specified matchers."""
    for key, matcher in matchers.items():
        actual = fields.get(key)
        if not match_value(actual, matcher):
            return False
    return True


def _render_grpc_response(
    response: dict[str, Any],
    request_fields: dict[str, Any],
) -> dict[str, Any]:
    """Render template variables in a gRPC response."""
    return render_template(response, body=request_fields)


class GrpcMockServer:
    """Manages a gRPC server for mock responses.

    This is a placeholder that will be expanded when gRPC support is
    fully wired.  The matching logic above can be used standalone.
    """

    def __init__(self, routes: list[GrpcRoute], port: int) -> None:
        self._routes = routes
        self._port = port
        self._server = None

    async def start(self) -> None:
        """Start the gRPC server."""
        try:
            import grpc  # pylint: disable=import-outside-toplevel

            self._server = grpc.aio.server()
            self._server.add_insecure_port(f"[::]:{self._port}")
            self._server.add_generic_rpc_handlers([MockRpcHandler(self._routes)])
            await self._server.start()
            logger.info("gRPC mock server started on port %d", self._port)
        except ImportError:
            logger.warning("grpcio not installed — gRPC mock server disabled")

    async def stop(self) -> None:
        """Stop the gRPC server."""
        if self._server is not None:
            await self._server.stop(grace=2)
            self._server = None


class MockRpcHandler:
    """Generic gRPC handler that routes RPCs to mock responses."""

    def __init__(self, routes: list[GrpcRoute]) -> None:
        self._routes = routes

    def service(self, handler_call_details):  # noqa: ANN001, ANN201
        """Return a handler for the incoming RPC, or None."""
        method_full = handler_call_details.method
        # method_full looks like /package.Service/Method
        parts = method_full.lstrip("/").split("/")
        if len(parts) != 2:
            return None

        service_name = parts[0]
        method_name = parts[1]

        # Check if any route matches
        for route in self._routes:
            if route.service == service_name and route.method == method_name:
                return _create_unary_handler(self._routes, service_name, method_name)
        return None


def _create_unary_handler(routes, service, method):  # noqa: ANN001, ANN201
    """Create a unary-unary handler function for the matched gRPC method."""

    async def handler(request_bytes, context):  # noqa: ANN001, ANN201
        try:
            request_fields = json.loads(request_bytes) if request_bytes else {}
        except (json.JSONDecodeError, TypeError):
            request_fields = {}

        result = match_grpc_request(routes, service, method, request_fields)
        if result is None:
            import grpc  # pylint: disable=import-outside-toplevel

            await context.abort(grpc.StatusCode.NOT_FOUND, "No matching mock route")
            return b""

        status_code = result.get("status_code")
        if status_code and status_code != "OK":
            import grpc  # pylint: disable=import-outside-toplevel

            code = getattr(grpc.StatusCode, status_code, grpc.StatusCode.UNKNOWN)
            message = result.get("message", "Mock error")
            await context.abort(code, message)
            return b""

        fields = result.get("fields", result)
        return json.dumps(fields).encode()

    import grpc as _grpc  # pylint: disable=import-outside-toplevel

    return _grpc.unary_unary_rpc_method_handler(handler)
