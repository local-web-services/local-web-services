"""Lambda Function URL operation handlers."""

from __future__ import annotations

from typing import Any

from fastapi import Request, Response

from lws.logging.logger import get_logger
from lws.providers._shared.request_helpers import parse_json_body
from lws.providers.lambda_runtime._lambda_function_ops import _function_arn, _json_response

_logger = get_logger("ldk.lambda-mgmt")


async def handle_create_function_url_config(
    function_name: str,
    request: Request,
    registry: Any,
    allocate_port_fn: Any,
) -> Response:
    """Handle CreateFunctionUrlConfig."""
    body = await parse_json_body(request)
    if registry.get_function_url(function_name) is not None:
        return _json_response(
            {
                "Message": f"Function URL already exists for: {function_name}",
                "Type": "ResourceConflictException",
            },
            409,
        )
    auth_type = body.get("AuthType", "NONE")
    cors = body.get("Cors")
    invoke_mode = body.get("InvokeMode", "BUFFERED")

    url_config: dict[str, Any] = {
        "FunctionName": function_name,
        "FunctionArn": _function_arn(function_name),
        "AuthType": auth_type,
        "Cors": cors,
        "InvokeMode": invoke_mode,
        "FunctionUrl": "",
        "CreationTime": "",
    }

    compute = registry.get_compute(function_name)
    if compute is not None:
        port = allocate_port_fn()
        url_config["FunctionUrl"] = f"http://localhost:{port}/"
        url_config["_port"] = port

        from lws.providers.lambda_function_url.provider import (  # pylint: disable=import-outside-toplevel
            LambdaFunctionUrlProvider,
        )

        provider = LambdaFunctionUrlProvider(
            function_name=function_name,
            compute=compute,
            port=port,
            cors_config=cors,
        )
        try:
            await provider.start()
            registry.register_function_url(function_name, url_config, provider)
        except Exception as exc:
            _logger.error("Failed to start Function URL for %s: %s", function_name, exc)
            registry.register_function_url(function_name, url_config)
    else:
        registry.register_function_url(function_name, url_config)

    _logger.info("Created Function URL for %s", function_name)
    return _json_response(url_config, 201)


async def handle_get_function_url_config(function_name: str, registry: Any) -> Response:
    """Handle GetFunctionUrlConfig."""
    url_config = registry.get_function_url(function_name)
    if url_config is None:
        return _json_response(
            {
                "Message": f"Function URL config not found for: {function_name}",
                "Type": "ResourceNotFoundException",
            },
            404,
        )
    return _json_response(url_config)


async def handle_update_function_url_config(
    function_name: str,
    request: Request,
    registry: Any,
) -> Response:
    """Handle UpdateFunctionUrlConfig."""
    body = await parse_json_body(request)
    url_config = registry.get_function_url(function_name)
    if url_config is None:
        return _json_response(
            {
                "Message": f"Function URL config not found for: {function_name}",
                "Type": "ResourceNotFoundException",
            },
            404,
        )
    if "AuthType" in body:
        url_config["AuthType"] = body["AuthType"]
    if "Cors" in body:
        url_config["Cors"] = body["Cors"]
    if "InvokeMode" in body:
        url_config["InvokeMode"] = body["InvokeMode"]
    _logger.info("Updated Function URL config for %s", function_name)
    return _json_response(url_config)


async def handle_delete_function_url_config(function_name: str, registry: Any) -> Response:
    """Handle DeleteFunctionUrlConfig."""
    provider = registry.function_url_providers.get(function_name)
    if provider is not None:
        try:
            await provider.stop()
        except Exception as exc:
            _logger.warning("Error stopping Function URL provider for %s: %s", function_name, exc)
    registry.delete_function_url(function_name)
    return Response(status_code=204)
