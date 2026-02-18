"""SSM Parameter Store HTTP routes.

Implements the SSM wire protocol that AWS SDKs and Terraform use,
using JSON request/response format with X-Amz-Target header dispatch.
"""

from __future__ import annotations

import json
import time
from typing import Any

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers._shared.aws_operation_mock import AwsMockConfig, AwsOperationMockMiddleware
from lws.providers._shared.request_helpers import parse_json_body, resolve_api_action

_logger = get_logger("ldk.ssm")

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


# ------------------------------------------------------------------
# In-memory state
# ------------------------------------------------------------------


class _Parameter:
    """Represents an SSM parameter."""

    def __init__(
        self,
        name: str,
        value: str,
        param_type: str = "String",
        description: str = "",
        tags: dict[str, str] | None = None,
    ) -> None:
        self.name = name
        self.value = value
        self.type = param_type
        self.description = description
        self.version = 1
        self.tags: dict[str, str] = tags or {}
        self.last_modified_date: float = time.time()
        self.arn = f"arn:aws:ssm:{_REGION}:{_ACCOUNT_ID}:parameter{name}"


class _SsmState:
    """In-memory store for SSM parameters."""

    def __init__(self) -> None:
        self._parameters: dict[str, _Parameter] = {}

    @property
    def parameters(self) -> dict[str, _Parameter]:
        """Return the parameters store."""
        return self._parameters


# ------------------------------------------------------------------
# Action handlers
# ------------------------------------------------------------------


async def _handle_put_parameter(state: _SsmState, body: dict) -> Response:
    name = body.get("Name", "")
    value = body.get("Value", "")
    param_type = body.get("Type", "String")
    description = body.get("Description", "")
    overwrite = body.get("Overwrite", False)
    tags_list = body.get("Tags", [])
    tags = {t["Key"]: t["Value"] for t in tags_list} if tags_list else {}

    existing = state.parameters.get(name)
    if existing and not overwrite:
        return _error_response(
            "ParameterAlreadyExists",
            "The parameter already exists. To overwrite set Overwrite to true.",
        )

    if existing:
        existing.value = value
        existing.type = param_type
        if description:
            existing.description = description
        existing.version += 1
        existing.last_modified_date = time.time()
        if tags:
            existing.tags.update(tags)
        version = existing.version
    else:
        param = _Parameter(
            name=name,
            value=value,
            param_type=param_type,
            description=description,
            tags=tags,
        )
        state.parameters[name] = param
        version = param.version

    return _json_response({"Version": version, "Tier": "Standard"})


async def _handle_get_parameter(state: _SsmState, body: dict) -> Response:
    name = body.get("Name", "")
    with_decryption = body.get("WithDecryption", False)
    param = state.parameters.get(name)
    if param is None:
        return _error_response(
            "ParameterNotFound",
            f"Parameter {name} not found.",
            status_code=400,
        )
    return _json_response({"Parameter": _format_parameter(param, with_decryption=with_decryption)})


async def _handle_get_parameters(state: _SsmState, body: dict) -> Response:
    names = body.get("Names", [])
    with_decryption = body.get("WithDecryption", False)
    parameters = []
    invalid = []
    for name in names:
        param = state.parameters.get(name)
        if param:
            parameters.append(_format_parameter(param, with_decryption=with_decryption))
        else:
            invalid.append(name)
    return _json_response({"Parameters": parameters, "InvalidParameters": invalid})


async def _handle_get_parameters_by_path(state: _SsmState, body: dict) -> Response:
    path = body.get("Path", "/")
    recursive = body.get("Recursive", False)
    with_decryption = body.get("WithDecryption", False)

    parameters = []
    for name, param in state.parameters.items():
        if recursive:
            if name.startswith(path):
                parameters.append(_format_parameter(param, with_decryption=with_decryption))
        else:
            # Non-recursive: only direct children
            if name.startswith(path):
                remainder = name[len(path) :].lstrip("/")
                if "/" not in remainder:
                    parameters.append(_format_parameter(param, with_decryption=with_decryption))

    return _json_response({"Parameters": parameters})


async def _handle_delete_parameter(state: _SsmState, body: dict) -> Response:
    name = body.get("Name", "")
    if name not in state.parameters:
        return _error_response(
            "ParameterNotFound",
            f"Parameter {name} not found.",
            status_code=400,
        )
    del state.parameters[name]
    return _json_response({})


async def _handle_delete_parameters(state: _SsmState, body: dict) -> Response:
    names = body.get("Names", [])
    deleted = []
    invalid = []
    for name in names:
        if name in state.parameters:
            del state.parameters[name]
            deleted.append(name)
        else:
            invalid.append(name)
    return _json_response({"DeletedParameters": deleted, "InvalidParameters": invalid})


async def _handle_describe_parameters(state: _SsmState, body: dict) -> Response:
    filters = body.get("ParameterFilters", [])
    params_list = list(state.parameters.values())
    params_list = _apply_parameter_filters(params_list, filters)
    descriptions = [_format_parameter_metadata(p) for p in params_list]
    return _json_response({"Parameters": descriptions})


async def _handle_add_tags_to_resource(state: _SsmState, body: dict) -> Response:
    resource_id = body.get("ResourceId", "")
    resource_type = body.get("ResourceType", "Parameter")
    tags_list = body.get("Tags", [])

    if resource_type == "Parameter":
        param = state.parameters.get(resource_id)
        if param is None:
            return _error_response(
                "InvalidResourceId",
                f"Parameter {resource_id} not found.",
                status_code=400,
            )
        for tag in tags_list:
            param.tags[tag["Key"]] = tag["Value"]

    return _json_response({})


async def _handle_remove_tags_from_resource(state: _SsmState, body: dict) -> Response:
    resource_id = body.get("ResourceId", "")
    resource_type = body.get("ResourceType", "Parameter")
    tag_keys = body.get("TagKeys", [])

    if resource_type == "Parameter":
        param = state.parameters.get(resource_id)
        if param is None:
            return _error_response(
                "InvalidResourceId",
                f"Parameter {resource_id} not found.",
                status_code=400,
            )
        for key in tag_keys:
            param.tags.pop(key, None)

    return _json_response({})


async def _handle_list_tags_for_resource(state: _SsmState, body: dict) -> Response:
    resource_id = body.get("ResourceId", "")
    resource_type = body.get("ResourceType", "Parameter")

    tags: list[dict[str, str]] = []
    if resource_type == "Parameter":
        param = state.parameters.get(resource_id)
        if param is not None:
            tags = [{"Key": k, "Value": v} for k, v in param.tags.items()]

    return _json_response({"TagList": tags})


# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------


def _apply_parameter_filters(
    params_list: list[_Parameter],
    filters: list[dict],
) -> list[_Parameter]:
    """Apply ParameterFilters to a list of parameters."""
    for f in filters:
        key = f.get("Key", "")
        values = f.get("Values", [])
        option = f.get("Option", "Equals")
        if key == "Name":
            params_list = _filter_by_name(params_list, values, option)
    return params_list


def _name_matches_equals(name: str, values: list[str]) -> bool:
    return name in values


def _name_matches_begins_with(name: str, values: list[str]) -> bool:
    return any(name.startswith(v) for v in values)


def _name_matches_contains(name: str, values: list[str]) -> bool:
    return any(v in name for v in values)


_NAME_MATCHERS = {
    "Equals": _name_matches_equals,
    "BeginsWith": _name_matches_begins_with,
    "Contains": _name_matches_contains,
}


def _filter_by_name(
    params_list: list[_Parameter],
    values: list[str],
    option: str,
) -> list[_Parameter]:
    """Filter parameters by name using the given option."""
    matcher = _NAME_MATCHERS.get(option)
    if matcher is None:
        return params_list
    return [p for p in params_list if matcher(p.name, values)]


def _format_parameter(param: _Parameter, *, with_decryption: bool = False) -> dict[str, Any]:
    """Format a parameter for API response."""
    value = param.value
    if param.type == "SecureString" and not with_decryption:
        value = "***"
    return {
        "Name": param.name,
        "Type": param.type,
        "Value": value,
        "Version": param.version,
        "LastModifiedDate": param.last_modified_date,
        "ARN": param.arn,
        "DataType": "text",
    }


def _format_parameter_metadata(param: _Parameter) -> dict[str, Any]:
    """Format a parameter for DescribeParameters response."""
    return {
        "Name": param.name,
        "Type": param.type,
        "Description": param.description,
        "Version": param.version,
        "LastModifiedDate": param.last_modified_date,
        "ARN": param.arn,
        "Tier": "Standard",
        "DataType": "text",
    }


def _json_response(data: dict, status_code: int = 200) -> Response:
    """Return a JSON response."""
    return Response(
        content=json.dumps(data, default=str),
        status_code=status_code,
        media_type="application/x-amz-json-1.1",
    )


def _error_response(code: str, message: str, status_code: int = 400) -> Response:
    """Return an error response in SSM format."""
    error_body = {"__type": code, "message": message}
    return _json_response(error_body, status_code=status_code)


# ------------------------------------------------------------------
# Action dispatch table
# ------------------------------------------------------------------


_ACTION_HANDLERS: dict[str, Any] = {
    "PutParameter": _handle_put_parameter,
    "GetParameter": _handle_get_parameter,
    "GetParameters": _handle_get_parameters,
    "GetParametersByPath": _handle_get_parameters_by_path,
    "DeleteParameter": _handle_delete_parameter,
    "DeleteParameters": _handle_delete_parameters,
    "DescribeParameters": _handle_describe_parameters,
    "AddTagsToResource": _handle_add_tags_to_resource,
    "RemoveTagsFromResource": _handle_remove_tags_from_resource,
    "ListTagsForResource": _handle_list_tags_for_resource,
}


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_ssm_app(
    initial_parameters: list[dict] | None = None,
    chaos: AwsChaosConfig | None = None,
    aws_mock: AwsMockConfig | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the SSM wire protocol."""
    app = FastAPI(title="LDK SSM")
    if aws_mock is not None:
        app.add_middleware(AwsOperationMockMiddleware, mock_config=aws_mock, service="ssm")
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="ssm")
    state = _SsmState()

    if initial_parameters:
        for p in initial_parameters:
            param = _Parameter(
                name=p["name"],
                value=p.get("value", ""),
                param_type=p.get("type", "String"),
                description=p.get("description", ""),
            )
            state.parameters[param.name] = param

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        target = request.headers.get("x-amz-target", "")
        body = await parse_json_body(request)
        action = resolve_api_action(target, body)

        handler = _ACTION_HANDLERS.get(action)
        if handler is None:
            _logger.warning("Unknown SSM action: %s", action)
            return _error_response(
                "InvalidAction",
                f"lws: SSM operation '{action}' is not yet implemented",
            )

        return await handler(state, body)

    return app
