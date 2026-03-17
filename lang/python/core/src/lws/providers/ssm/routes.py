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
from lws.providers._shared.aws_iam_auth import IamAuthBundle, add_iam_auth_middleware
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.aws_operation_fake import AwsFakeConfig, AwsOperationFakeMiddleware
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

    def reset(self) -> None:
        """Clear all parameters from the store."""
        self._parameters.clear()


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
# App factory helpers
# ------------------------------------------------------------------

_SINGLE_PARAM_READ_ACTIONS = {"GetParameter"}
_MULTI_PARAM_READ_ACTIONS = {"GetParameters"}
_DELETE_SINGLE_ACTION = "DeleteParameter"
_DELETE_MULTI_ACTION = "DeleteParameters"


def _ssm_param_not_found(name: str, param_state: str) -> Response:
    return Response(
        content=json.dumps(
            {
                "__type": "ParameterNotFound",
                "message": f"Parameter {name} not found (status: {param_state})",
            }
        ),
        status_code=400,
        media_type="application/json",
    )


def _ssm_param_still_creating(name: str) -> Response:
    return Response(
        content=json.dumps(
            {
                "__type": "ParameterNotFound",
                "message": f"Parameter {name} is still being created",
            }
        ),
        status_code=400,
        media_type="application/json",
    )


def _check_single_param_lifecycle(
    action: str, body: dict, lc: ResourceLifecycleConfig, tracker: ResourceStateTracker
) -> Response | None:
    if not lc.enabled or action not in _SINGLE_PARAM_READ_ACTIONS:
        return None
    name = body.get("Name", "")
    if not name:
        return None
    param_state = tracker.get_state(name)
    if param_state in ("CREATING", "DELETING"):
        return _ssm_param_not_found(name, param_state)
    return None


def _check_multi_param_lifecycle(
    action: str, body: dict, lc: ResourceLifecycleConfig, tracker: ResourceStateTracker
) -> Response | None:
    if not lc.enabled or action not in _MULTI_PARAM_READ_ACTIONS:
        return None
    for name in body.get("Names", []):
        param_state = tracker.get_state(name)
        if param_state in ("CREATING", "DELETING"):
            return _ssm_param_not_found(name, param_state)
    return None


async def _lifecycle_put_parameter(
    handler: Any,
    state: Any,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response | None:
    """Handle lifecycle for PutParameter. Returns a Response or None to fall through."""
    name = body.get("Name", "")
    overwrite = body.get("Overwrite", False)
    if overwrite and name:
        param_state = tracker.get_state(name)
        if param_state in ("CREATING", "DELETING"):
            return _ssm_param_not_found(name, param_state)
    if lc.create_dwell_ms > 0:
        resp = await handler(state, body)
        if resp.status_code == 200:
            tracker.set_state(name, "CREATING")
            tracker.schedule_transition(name, "ACTIVE", lc.create_dwell_ms)
        return resp
    return None


async def _lifecycle_delete_parameter(
    handler: Any,
    state: Any,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware DeleteParameter."""
    name = body.get("Name", "")
    if tracker.get_state(name) == "CREATING":
        return _ssm_param_still_creating(name)
    resp = await handler(state, body)
    if resp.status_code == 200:
        if lc.delete_dwell_ms > 0:
            tracker.set_state(name, "DELETING")
            tracker.schedule_transition(name, None, lc.delete_dwell_ms)
        else:
            tracker.remove(name)
    return resp


async def _lifecycle_delete_parameters(
    handler: Any,
    state: Any,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware DeleteParameters."""
    names = body.get("Names", [])
    for name in names:
        if tracker.get_state(name) == "CREATING":
            return _ssm_param_still_creating(name)
    resp = await handler(state, body)
    if resp.status_code == 200:
        for name in names:
            if lc.delete_dwell_ms > 0:
                tracker.set_state(name, "DELETING")
                tracker.schedule_transition(name, None, lc.delete_dwell_ms)
            else:
                tracker.remove(name)
    return resp


def _check_resource_tag_lifecycle(
    body: dict, _lc: ResourceLifecycleConfig, tracker: ResourceStateTracker
) -> Response | None:
    resource_id = body.get("ResourceId", "")
    resource_type = body.get("ResourceType", "Parameter")
    if resource_type == "Parameter" and resource_id:
        param_state = tracker.get_state(resource_id)
        if param_state in ("CREATING", "DELETING"):
            return Response(
                content=json.dumps(
                    {
                        "__type": "InvalidResourceId",
                        "message": f"Parameter {resource_id} not found (status: {param_state})",
                    }
                ),
                status_code=400,
                media_type="application/json",
            )
    return None


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

    err = _check_single_param_lifecycle(action, body, lc, tracker)
    if err is not None:
        return err

    err = _check_multi_param_lifecycle(action, body, lc, tracker)
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
        result = await _handle_ssm_lifecycle(action, handler, state, body, lc, tracker)
        if result is not None:
            return result

    return await handler(state, body)


async def _handle_ssm_lifecycle(
    action: str,
    handler: Any,
    state: _SsmState,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response | None:
    if action == "PutParameter":
        return await _lifecycle_put_parameter(handler, state, body, lc, tracker)
    if action == _DELETE_SINGLE_ACTION:
        return await _lifecycle_delete_parameter(handler, state, body, lc, tracker)
    if action == _DELETE_MULTI_ACTION:
        return await _lifecycle_delete_parameters(handler, state, body, lc, tracker)
    if action in ("AddTagsToResource", "ListTagsForResource"):
        return _check_resource_tag_lifecycle(body, lc, tracker)
    return None


def create_ssm_app(
    initial_parameters: list[dict] | None = None,
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    iam_auth: IamAuthBundle | None = None,
    state: _SsmState | None = None,
    lifecycle: ResourceLifecycleConfig | None = None,
) -> tuple[FastAPI, _SsmState]:
    """Create a FastAPI application that speaks the SSM wire protocol.

    Returns a tuple of (app, state) so callers can retain a reference to the
    state object for lifecycle management (e.g. reset).
    """
    _lc = lifecycle or ResourceLifecycleConfig()
    _tracker = ResourceStateTracker(_lc)

    app = FastAPI(title="LDK SSM")
    if aws_fake is not None:
        app.add_middleware(AwsOperationFakeMiddleware, fake_config=aws_fake, service="ssm")
    add_iam_auth_middleware(app, "ssm", iam_auth, ErrorFormat.JSON)
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="ssm")
    if state is None:
        state = _SsmState()

    if initial_parameters:
        _populate_ssm_state(state, initial_parameters)

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        return await _ssm_dispatch(request, state, _lc, _tracker)

    return app, state
