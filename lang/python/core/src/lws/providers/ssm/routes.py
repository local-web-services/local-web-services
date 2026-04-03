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
from lws.providers._shared.aws_cloudtrail_middleware import apply_cloudtrail_middleware
from lws.providers._shared.aws_iam_auth import IamAuthBundle, add_iam_auth_middleware
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.aws_operation_fake import AwsFakeConfig, AwsOperationFakeMiddleware
from lws.providers._shared.per_account_state import (
    DEFAULT_ACCOUNT_ID,
    PerAccountStateRegistry,
    extract_account_id_from_token,
)
from lws.providers._shared.provider_context import ProviderContext
from lws.providers._shared.request_helpers import parse_json_body, resolve_api_action
from lws.providers.ssm._ssm_lifecycle import (
    check_multi_param_lifecycle,
    check_single_param_lifecycle,
    handle_ssm_lifecycle,
)
from lws.providers.ssm._ssm_state import (
    _apply_parameter_filters,
    _format_parameter,
    _format_parameter_metadata,
    _Parameter,
    _SsmState,
)

_logger = get_logger("ldk.ssm")


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


def _populate_ssm_state(state: _SsmState, initial_parameters: list[dict]) -> None:
    """Load initial parameters into the SSM state."""
    for p in initial_parameters:
        param = _Parameter(
            name=p["name"],
            value=p.get("value", ""),
            param_type=p.get("type", "String"),
            description=p.get("description", ""),
        )
        state.parameters[param.name] = param


async def _ssm_dispatch(
    request: Request,
    state: _SsmState,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    target = request.headers.get("x-amz-target", "")
    body = await parse_json_body(request)
    action = resolve_api_action(target, body)

    err = check_single_param_lifecycle(action, body, lc, tracker)
    if err is not None:
        return err

    err = check_multi_param_lifecycle(action, body, lc, tracker)
    if err is not None:
        return err

    handler = _ACTION_HANDLERS.get(action)
    if handler is None:
        _logger.warning("Unknown SSM action: %s", action)
        return _error_response(
            "InvalidAction",
            f"lws: SSM operation '{action}' is not yet implemented",
        )

    if lc.enabled:
        result = await handle_ssm_lifecycle(action, handler, state, body, lc, tracker)
        if result is not None:
            return result

    return await handler(state, body)


def create_ssm_app(
    initial_parameters: list[dict] | None = None,
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    iam_auth: IamAuthBundle | None = None,
    state: _SsmState | None = None,
    lifecycle: ResourceLifecycleConfig | None = None,
    context: ProviderContext | None = None,
    registry: PerAccountStateRegistry[_SsmState] | None = None,
) -> tuple[FastAPI, _SsmState]:
    """Create a FastAPI application that speaks the SSM wire protocol.

    Returns a tuple of (app, state) so callers can retain a reference to the
    state object for lifecycle management (e.g. reset).  The returned state is
    always the default-account state.
    """
    _lc = lifecycle or ResourceLifecycleConfig()
    _account_trackers: dict[str, ResourceStateTracker] = {}

    if registry is None:
        registry = PerAccountStateRegistry(_SsmState)
        if state is not None:
            registry._accounts[DEFAULT_ACCOUNT_ID] = state  # pylint: disable=protected-access

    default_state = registry.get(DEFAULT_ACCOUNT_ID)
    if initial_parameters:
        _populate_ssm_state(default_state, initial_parameters)

    app = FastAPI(title="LDK SSM")
    if aws_fake is not None:
        app.add_middleware(AwsOperationFakeMiddleware, fake_config=aws_fake, service="ssm")
    add_iam_auth_middleware(app, "ssm", iam_auth, ErrorFormat.JSON)
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="ssm")

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        token = request.headers.get("X-Amz-Security-Token", "")
        account_id = extract_account_id_from_token(token) if token else DEFAULT_ACCOUNT_ID
        _state = registry.get(account_id)
        if account_id not in _account_trackers:
            _account_trackers[account_id] = ResourceStateTracker(_lc)
        return await _ssm_dispatch(request, _state, _lc, _account_trackers[account_id])

    apply_cloudtrail_middleware(app, context.cloudtrail if context else None, "ssm")
    return app, default_state
