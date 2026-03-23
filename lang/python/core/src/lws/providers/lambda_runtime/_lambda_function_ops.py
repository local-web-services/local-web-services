"""Lambda function CRUD operation handlers."""

from __future__ import annotations

import json
import uuid
from typing import Any

from fastapi import Request, Response

from lws.logging.logger import get_logger
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers.lambda_runtime._lambda_code_resolver import (  # noqa: F401
    resolve_code_path,
    resolve_code_path_from_name,
)

_logger = get_logger("ldk.lambda-mgmt")

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


def _json_response(data: dict, status_code: int = 200) -> Response:
    return Response(
        content=json.dumps(data, default=str),
        status_code=status_code,
        media_type="application/json",
    )


def _function_arn(name: str) -> str:
    return f"arn:aws:lambda:{_REGION}:{_ACCOUNT_ID}:function:{name}"


def _invoke_arn(name: str) -> str:
    """Build the API Gateway invoke ARN for a Lambda function."""
    func_arn = _function_arn(name)
    return f"arn:aws:apigateway:{_REGION}:lambda:path/2015-03-31/functions/{func_arn}/invocations"


def _format_function_config(config: dict[str, Any]) -> dict[str, Any]:
    name = config.get("FunctionName", "")
    func_arn = _function_arn(name)
    return {
        "FunctionName": name,
        "FunctionArn": func_arn,
        "Runtime": config.get("Runtime", "nodejs18.x"),
        "Role": config.get("Role", ""),
        "Handler": config.get("Handler", "index.handler"),
        "CodeSize": 0,
        "Description": config.get("Description", ""),
        "Timeout": config.get("Timeout", 3),
        "MemorySize": config.get("MemorySize", 128),
        "LastModified": "2024-01-01T00:00:00.000+0000",
        "CodeSha256": "stub",
        "Version": "$LATEST",
        "TracingConfig": {"Mode": "PassThrough"},
        "RevisionId": str(uuid.uuid4()),
        "State": "Active",
        "LastUpdateStatus": "Successful",
        "PackageType": "Zip",
        "Architectures": ["x86_64"],
        "EphemeralStorage": {"Size": 512},
        "Environment": {"Variables": config.get("Environment", {}).get("Variables", {})},
        "InvokeArn": _invoke_arn(name),
    }


async def handle_create_function(
    request: Request,
    registry: Any,
    create_compute_fn: Any,
    lifecycle: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle CreateFunction."""
    from lws.providers._shared.request_helpers import (  # pylint: disable=import-outside-toplevel
        parse_json_body,
    )

    body = await parse_json_body(request)
    function_name = body.get("FunctionName", "")
    if not function_name:
        return _json_response({"message": "FunctionName is required"}, 400)

    if registry.get_config(function_name) is not None:
        return _json_response(
            {
                "__type": "ResourceConflictException",
                "Message": f"Function already exist: {function_name}",
            },
            409,
        )

    func_config = {
        "FunctionName": function_name,
        "Runtime": body.get("Runtime", "nodejs18.x"),
        "Role": body.get("Role", ""),
        "Handler": body.get("Handler", "index.handler"),
        "Description": body.get("Description", ""),
        "Timeout": body.get("Timeout", 3),
        "MemorySize": body.get("MemorySize", 128),
        "Environment": body.get("Environment", {}),
        "Code": body.get("Code", {}),
    }

    compute = create_compute_fn(func_config)
    await compute.start()
    registry.register(function_name, func_config, compute)

    runtime = func_config.get("Runtime")
    _logger.info("Created Lambda function: %s (runtime=%s)", function_name, runtime)

    resp = _json_response(_format_function_config(func_config), 201)
    if lifecycle.enabled and lifecycle.create_dwell_ms > 0:
        tracker.set_state(function_name, "CREATING")
        tracker.schedule_transition(function_name, "ACTIVE", lifecycle.create_dwell_ms)
    return resp


async def handle_list_functions(registry: Any) -> Response:
    """Handle ListFunctions."""
    functions = registry.list_functions()
    return _json_response(
        {
            "Functions": [_format_function_config(f) for f in functions],
        }
    )


async def handle_get_function(
    function_name: str,
    registry: Any,
    lifecycle: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle GetFunction."""
    config = registry.get_config(function_name)
    if config is None:
        return _json_response(
            {
                "Message": f"Function not found: {function_name}",
                "__type": "ResourceNotFoundException",
            },
            404,
        )
    if lifecycle.enabled:
        state = tracker.get_state(function_name)
        if state in ("CREATING", "DELETING"):
            return _json_response(
                {
                    "Message": f"Function {function_name} is in state {state}",
                    "__type": "ResourceConflictException",
                },
                409,
            )
    return _json_response(
        {
            "Configuration": _format_function_config(config),
            "Code": {"RepositoryType": "S3", "Location": ""},
        }
    )


async def handle_delete_function(
    function_name: str,
    registry: Any,
    lifecycle: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle DeleteFunction."""
    if registry.get_config(function_name) is None:
        if not (lifecycle.enabled and tracker.get_state(function_name) is not None):
            return _json_response(
                {
                    "Message": f"Function not found: {function_name}",
                    "__type": "ResourceNotFoundException",
                },
                404,
            )
    if lifecycle.enabled:
        state = tracker.get_state(function_name)
        if state == "CREATING":
            return _json_response(
                {
                    "Message": f"Function {function_name} is still being created",
                    "__type": "ResourceConflictException",
                },
                409,
            )
        if state == "DELETING":
            return _json_response(
                {
                    "Message": f"Function {function_name} is already being deleted",
                    "__type": "ResourceConflictException",
                },
                409,
            )
    registry.delete(function_name)
    if lifecycle.enabled:
        if lifecycle.delete_dwell_ms > 0:
            tracker.set_state(function_name, "DELETING")
            tracker.schedule_transition(function_name, None, lifecycle.delete_dwell_ms)
        else:
            tracker.remove(function_name)
    return Response(status_code=204)


async def handle_update_function_configuration(
    function_name: str,
    request: Request,
    registry: Any,
    lifecycle: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle UpdateFunctionConfiguration."""
    from lws.providers._shared.request_helpers import (  # pylint: disable=import-outside-toplevel
        parse_json_body,
    )

    body = await parse_json_body(request)
    config = registry.get_config(function_name)
    if config is None:
        return _json_response(
            {
                "Message": f"Function not found: {function_name}",
                "__type": "ResourceNotFoundException",
            },
            404,
        )
    if lifecycle.enabled:
        state = tracker.get_state(function_name)
        if state in ("CREATING", "DELETING"):
            return _json_response(
                {
                    "Message": f"Function {function_name} is in state {state}",
                    "__type": "ResourceConflictException",
                },
                409,
            )
    updates: dict[str, Any] = {}
    for key in ("Handler", "Runtime", "Timeout", "MemorySize", "Description", "Role"):
        if key in body:
            updates[key] = body[key]
    if "Environment" in body:
        updates["Environment"] = body["Environment"]
    registry.update_config(function_name, updates)
    updated_config = registry.get_config(function_name)
    _logger.info("Updated configuration for Lambda function: %s", function_name)
    return _json_response(_format_function_config(updated_config))


async def handle_update_function_code(
    function_name: str,
    request: Request,
    registry: Any,
    lifecycle: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle UpdateFunctionCode."""
    from lws.providers._shared.request_helpers import (  # pylint: disable=import-outside-toplevel
        parse_json_body,
    )

    await parse_json_body(request)  # consume body
    config = registry.get_config(function_name)
    if config is None:
        return _json_response(
            {
                "Message": f"Function not found: {function_name}",
                "__type": "ResourceNotFoundException",
            },
            404,
        )
    if lifecycle.enabled:
        state = tracker.get_state(function_name)
        if state in ("CREATING", "DELETING"):
            return _json_response(
                {
                    "Message": f"Function {function_name} is in state {state}",
                    "__type": "ResourceConflictException",
                },
                409,
            )
    _logger.info("UpdateFunctionCode called for %s (no-op in local dev)", function_name)
    return _json_response(_format_function_config(config))


async def handle_list_versions(function_name: str, registry: Any) -> Response:
    """Handle ListVersionsByFunction."""
    config = registry.get_config(function_name)
    if config is None:
        return _json_response(
            {
                "Message": f"Function not found: {function_name}",
                "__type": "ResourceNotFoundException",
            },
            404,
        )
    return _json_response({"Versions": [_format_function_config(config)]})


async def handle_get_code_signing_config(function_name: str) -> Response:
    """Handle GetFunctionCodeSigningConfig."""
    return _json_response({"CodeSigningConfigArn": "", "FunctionName": function_name})


async def handle_add_permission(
    function_name: str,
    request: Request,
    permissions: dict[str, dict[str, Any]],
    registry: Any = None,
    lifecycle: ResourceLifecycleConfig | None = None,
    tracker: ResourceStateTracker | None = None,
) -> Response:
    """Handle AddPermission."""
    from lws.providers._shared.request_helpers import (  # pylint: disable=import-outside-toplevel
        parse_json_body,
    )

    if registry is not None and registry.get_config(function_name) is None:
        return _json_response(
            {
                "Message": f"Function not found: {function_name}",
                "__type": "ResourceNotFoundException",
            },
            404,
        )
    if lifecycle is not None and lifecycle.enabled and tracker is not None:
        state = tracker.get_state(function_name)
        if state in ("CREATING", "DELETING"):
            return _json_response(
                {
                    "Message": f"Function {function_name} is in state {state}",
                    "__type": "ResourceConflictException",
                },
                409,
            )
    body = await parse_json_body(request)
    sid = body.get("StatementId", str(uuid.uuid4())[:8])
    permissions.setdefault(function_name, {})[sid] = body
    qualifier = body.get("Qualifier", "$LATEST")
    qualified_arn = f"{_function_arn(function_name)}:{qualifier}"
    statement = {
        "Sid": sid,
        "Effect": "Allow",
        "Principal": body.get("Principal", "*"),
        "Action": body.get("Action", "lambda:InvokeFunction"),
        "Resource": qualified_arn,
    }
    if body.get("SourceArn"):
        statement["Condition"] = {"ArnLike": {"AWS:SourceArn": body["SourceArn"]}}
    return _json_response({"Statement": json.dumps(statement)}, 201)


async def handle_get_policy(
    function_name: str,
    permissions: dict[str, dict[str, Any]],
) -> Response:
    """Handle GetPolicy."""
    perms = permissions.get(function_name, {})
    qualified_arn = f"{_function_arn(function_name)}:$LATEST"
    statements = []
    for sid, p in perms.items():
        stmt = {
            "Sid": sid,
            "Effect": "Allow",
            "Principal": p.get("Principal", "*"),
            "Action": p.get("Action", "lambda:InvokeFunction"),
            "Resource": qualified_arn,
        }
        if p.get("SourceArn"):
            stmt["Condition"] = {"ArnLike": {"AWS:SourceArn": p["SourceArn"]}}
        statements.append(stmt)
    policy = {"Version": "2012-10-17", "Id": "default", "Statement": statements}
    return _json_response(
        {
            "Policy": json.dumps(policy),
            "RevisionId": str(uuid.uuid4()),
        }
    )


async def handle_remove_permission(
    function_name: str,
    sid: str,
    permissions: dict[str, dict[str, Any]],
) -> Response:
    """Handle RemovePermission."""
    func_perms = permissions.get(function_name)
    if func_perms is None or sid not in func_perms:
        return _json_response(
            {
                "Message": f"No policy or statement found for function: {function_name}/{sid}",
                "__type": "ResourceNotFoundException",
            },
            404,
        )
    func_perms.pop(sid, None)
    return Response(status_code=204)


def _function_name_from_arn(arn: str) -> str:
    """Extract function name from a Lambda ARN."""
    parts = arn.split(":")
    if len(parts) >= 7 and parts[5] == "function":
        return parts[6]
    return arn.split("/")[-1] if "/" in arn else arn


async def handle_tag_resource(arn: str, request: Request, registry: Any) -> Response:
    """Handle TagResource."""
    from lws.providers._shared.request_helpers import (  # pylint: disable=import-outside-toplevel
        parse_json_body,
    )

    function_name = _function_name_from_arn(arn)
    if registry.get_config(function_name) is None:
        return _json_response(
            {
                "Message": f"Function not found: {function_name}",
                "__type": "ResourceNotFoundException",
            },
            404,
        )
    body = await parse_json_body(request)
    tags = body.get("Tags", {})
    registry.tag_resource(arn, tags)
    _logger.info("Tagged resource %s with %d tags", arn, len(tags))
    return Response(status_code=204)


async def handle_untag_resource(arn: str, request: Request, registry: Any) -> Response:
    """Handle UntagResource."""
    function_name = _function_name_from_arn(arn)
    if registry.get_config(function_name) is None:
        return _json_response(
            {
                "Message": f"Function not found: {function_name}",
                "__type": "ResourceNotFoundException",
            },
            404,
        )
    tag_keys_param = request.query_params.get("tagKeys", "")
    tag_keys = [k for k in tag_keys_param.split(",") if k]
    registry.untag_resource(arn, tag_keys)
    _logger.info("Untagged resource %s, removed keys: %s", arn, tag_keys)
    return Response(status_code=204)


async def handle_list_tags(arn: str, registry: Any) -> Response:
    """Handle ListTags."""
    tags = registry.get_tags(arn)
    return _json_response({"Tags": tags})
