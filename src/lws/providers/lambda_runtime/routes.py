"""Lambda management HTTP routes.

Implements the Lambda REST management API that the AWS SDK and Terraform
use to create/read/delete Lambda functions and invoke them.

Also provides ``LambdaRegistry``, a shared registry of function name →
``ICompute`` instances used by both this module and the API Gateway V2
proxy to invoke Lambda functions.
"""

from __future__ import annotations

import json
import re
import uuid
from pathlib import Path
from typing import Any

from fastapi import APIRouter, FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.lambda_helpers import build_default_lambda_context
from lws.providers._shared.request_helpers import parse_json_body

_logger = get_logger("ldk.lambda-mgmt")

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


# ---------------------------------------------------------------------------
# Lambda Registry — shared between Lambda management and API Gateway proxy
# ---------------------------------------------------------------------------


class LambdaRegistry:
    """Maps Lambda function names to live ``ICompute`` instances.

    Shared between the Lambda management API (which creates compute
    providers when ``CreateFunction`` is called) and the API Gateway V2
    proxy (which invokes them).
    """

    def __init__(self) -> None:
        self._functions: dict[str, dict[str, Any]] = {}
        self._compute: dict[str, Any] = {}  # name -> ICompute
        self._tags: dict[str, dict[str, str]] = {}  # arn -> {key: value}

    @property
    def functions(self) -> dict[str, dict[str, Any]]:
        """Return the functions store."""
        return self._functions

    @property
    def compute(self) -> dict[str, Any]:
        """Return the compute providers store."""
        return self._compute

    def register(self, name: str, config: dict[str, Any], compute: Any) -> None:
        """Store a function configuration and its compute provider by name."""
        self._functions[name] = config
        self._compute[name] = compute

    def update_config(self, name: str, updates: dict[str, Any]) -> dict[str, Any] | None:
        """Merge updates into an existing function config, returning the result or None."""
        config = self._functions.get(name)
        if config is None:
            return None
        config.update(updates)
        return config

    def get_config(self, name: str) -> dict[str, Any] | None:
        """Return the stored configuration for a function, or None if not found."""
        return self._functions.get(name)

    def get_compute(self, name: str) -> Any | None:
        """Return the ICompute instance for a function, or None if not found."""
        return self._compute.get(name)

    def delete(self, name: str) -> bool:
        """Remove a function and its compute provider, returning True if it existed."""
        removed = name in self._functions
        self._functions.pop(name, None)
        self._compute.pop(name, None)
        return removed

    def list_functions(self) -> list[dict[str, Any]]:
        """Return all stored function configurations."""
        return list(self._functions.values())

    def get_tags(self, arn: str) -> dict[str, str]:
        """Return a copy of the tags associated with the given ARN."""
        return dict(self._tags.get(arn, {}))

    def tag_resource(self, arn: str, tags: dict[str, str]) -> None:
        """Add or overwrite tags on the resource identified by ARN."""
        self._tags.setdefault(arn, {}).update(tags)

    def untag_resource(self, arn: str, tag_keys: list[str]) -> None:
        """Remove the specified tag keys from the resource identified by ARN."""
        if arn in self._tags:
            for key in tag_keys:
                self._tags[arn].pop(key, None)


# ---------------------------------------------------------------------------
# In-memory state for stubs (event source mappings, permissions)
# ---------------------------------------------------------------------------


class _LambdaState:
    def __init__(self) -> None:
        self.event_source_mappings: dict[str, dict[str, Any]] = {}
        self.permissions: dict[str, dict[str, Any]] = {}  # func_name -> {sid: policy}


# ---------------------------------------------------------------------------
# Code path resolution
# ---------------------------------------------------------------------------


def _resolve_code_path(filename: str | None, project_dir: Path | None) -> Path | None:
    """Resolve the Lambda code path from Terraform's zip Filename.

    Terraform sends a ``Filename`` pointing to a zip. We look for the
    corresponding source directory by stripping ``.terraform-build/*.zip``
    → ``lambda/*`` relative to project_dir.  Falls back to the zip's
    parent directory.
    """
    if not filename:
        return None

    zip_path = Path(filename)

    # If it's a real directory already, use it
    if zip_path.is_dir():
        return zip_path

    # Try to find source dir by looking at the zip stem
    if project_dir is not None:
        # e.g. .terraform-build/create-order.zip → lambda/create-order/
        stem = zip_path.stem
        candidate = project_dir / "lambda" / stem
        if candidate.is_dir():
            return candidate

        # Also try: src/lambda/<stem>
        candidate2 = project_dir / "src" / "lambda" / stem
        if candidate2.is_dir():
            return candidate2

    # Fallback: use the parent of the zip
    if zip_path.parent.exists():
        return zip_path.parent

    return Path(".")


def _resolve_code_path_from_name(function_name: str, project_dir: Path) -> Path | None:
    """Try to find the Lambda source directory using the function name.

    Converts names like ``CreateOrderFunction`` to ``create-order`` and
    looks for a matching directory under ``lambda/`` or ``src/lambda/``.
    """
    # Strip common suffixes
    name = function_name
    for suffix in ("Function", "Lambda", "Handler"):
        if name.endswith(suffix):
            name = name[: -len(suffix)]
            break

    # Convert PascalCase to kebab-case
    kebab = re.sub(r"(?<=[a-z0-9])([A-Z])", r"-\1", name).lower()

    # Also try snake_case and plain lowercase
    snake = re.sub(r"(?<=[a-z0-9])([A-Z])", r"_\1", name).lower()
    lower = name.lower()

    candidates = [kebab, snake, lower, function_name]

    for candidate in candidates:
        for base in [project_dir / "lambda", project_dir / "src" / "lambda"]:
            path = base / candidate
            if path.is_dir():
                _logger.debug("Resolved code path for %s → %s", function_name, path)
                return path

    return None


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


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


# ---------------------------------------------------------------------------
# Router
# ---------------------------------------------------------------------------


class LambdaManagementRouter:
    """Route Lambda management requests."""

    def __init__(
        self,
        registry: LambdaRegistry,
        project_dir: Path | None = None,
        sdk_env: dict[str, str] | None = None,
    ) -> None:
        self._registry = registry
        self._project_dir = project_dir
        self._sdk_env = sdk_env or {}
        self._state = _LambdaState()
        self.router = APIRouter()
        self._register_routes()

    def _register_routes(self) -> None:
        r = self.router

        # Functions
        r.add_api_route(
            "/2015-03-31/functions",
            self._create_function,
            methods=["POST"],
        )
        r.add_api_route(
            "/2015-03-31/functions",
            self._list_functions,
            methods=["GET"],
        )
        r.add_api_route(
            "/2015-03-31/functions/{function_name}",
            self._get_function,
            methods=["GET"],
        )
        r.add_api_route(
            "/2015-03-31/functions/{function_name}",
            self._delete_function,
            methods=["DELETE"],
        )
        r.add_api_route(
            "/2015-03-31/functions/{function_name}/configuration",
            self._update_function_configuration,
            methods=["PUT"],
        )
        r.add_api_route(
            "/2015-03-31/functions/{function_name}/code",
            self._update_function_code,
            methods=["PUT"],
        )

        # Invocations
        r.add_api_route(
            "/2015-03-31/functions/{function_name}/invocations",
            self._invoke_function,
            methods=["POST"],
        )

        # Permissions (policy) - stubs
        r.add_api_route(
            "/2015-03-31/functions/{function_name}/policy",
            self._add_permission,
            methods=["POST"],
        )
        r.add_api_route(
            "/2015-03-31/functions/{function_name}/policy",
            self._get_policy,
            methods=["GET"],
        )
        r.add_api_route(
            "/2015-03-31/functions/{function_name}/policy/{sid}",
            self._remove_permission,
            methods=["DELETE"],
        )

        # Event source mappings - stubs
        r.add_api_route(
            "/2015-03-31/event-source-mappings",
            self._list_event_source_mappings,
            methods=["GET"],
        )
        r.add_api_route(
            "/2015-03-31/event-source-mappings",
            self._create_event_source_mapping,
            methods=["POST"],
        )
        r.add_api_route(
            "/2015-03-31/event-source-mappings/{esm_uuid}",
            self._get_event_source_mapping,
            methods=["GET"],
        )
        r.add_api_route(
            "/2015-03-31/event-source-mappings/{esm_uuid}",
            self._delete_event_source_mapping,
            methods=["DELETE"],
        )

        # Versions
        r.add_api_route(
            "/2015-03-31/functions/{function_name}/versions",
            self._list_versions,
            methods=["GET"],
        )

        # Code signing config - stub (both API versions)
        r.add_api_route(
            "/2015-03-31/functions/{function_name}/code-signing-config",
            self._get_code_signing_config,
            methods=["GET"],
        )
        r.add_api_route(
            "/2020-06-30/functions/{function_name}/code-signing-config",
            self._get_code_signing_config,
            methods=["GET"],
        )

        # Tags
        r.add_api_route(
            "/2017-03-31/tags/{arn:path}",
            self._tag_resource,
            methods=["POST"],
        )
        r.add_api_route(
            "/2017-03-31/tags/{arn:path}",
            self._untag_resource,
            methods=["DELETE"],
        )
        r.add_api_route(
            "/2017-03-31/tags/{arn:path}",
            self._list_tags,
            methods=["GET"],
        )
        r.add_api_route(
            "/2015-03-31/tags/{arn:path}",
            self._tag_resource,
            methods=["POST"],
        )
        r.add_api_route(
            "/2015-03-31/tags/{arn:path}",
            self._untag_resource,
            methods=["DELETE"],
        )
        r.add_api_route(
            "/2015-03-31/tags/{arn:path}",
            self._list_tags,
            methods=["GET"],
        )

        # Catch-all
        r.add_api_route(
            "/{path:path}",
            self._stub_handler,
            methods=["GET", "POST", "PUT", "PATCH", "DELETE"],
        )

    # -- Functions -----------------------------------------------------------

    async def _create_function(self, request: Request) -> Response:
        body = await parse_json_body(request)
        function_name = body.get("FunctionName", "")
        if not function_name:
            return _json_response({"message": "FunctionName is required"}, 400)

        # Store function config
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

        # Create compute provider
        compute = self._create_compute(func_config)
        await compute.start()
        self._registry.register(function_name, func_config, compute)

        runtime = func_config.get("Runtime")
        _logger.info("Created Lambda function: %s (runtime=%s)", function_name, runtime)
        return _json_response(_format_function_config(func_config), 201)

    async def _list_functions(self, _request: Request) -> Response:
        functions = self._registry.list_functions()
        return _json_response(
            {
                "Functions": [_format_function_config(f) for f in functions],
            }
        )

    async def _get_function(self, function_name: str) -> Response:
        config = self._registry.get_config(function_name)
        if config is None:
            return _json_response(
                {
                    "Message": f"Function not found: {function_name}",
                    "Type": "ResourceNotFoundException",
                },
                404,
            )
        return _json_response(
            {
                "Configuration": _format_function_config(config),
                "Code": {"RepositoryType": "S3", "Location": ""},
            }
        )

    async def _delete_function(self, function_name: str) -> Response:
        self._registry.delete(function_name)
        return Response(status_code=204)

    async def _update_function_configuration(
        self, function_name: str, request: Request
    ) -> Response:
        body = await parse_json_body(request)
        config = self._registry.get_config(function_name)
        if config is None:
            return _json_response(
                {
                    "Message": f"Function not found: {function_name}",
                    "Type": "ResourceNotFoundException",
                },
                404,
            )
        updates: dict[str, Any] = {}
        for key in ("Handler", "Runtime", "Timeout", "MemorySize", "Description", "Role"):
            if key in body:
                updates[key] = body[key]
        if "Environment" in body:
            updates["Environment"] = body["Environment"]
        self._registry.update_config(function_name, updates)
        updated_config = self._registry.get_config(function_name)
        _logger.info("Updated configuration for Lambda function: %s", function_name)
        return _json_response(_format_function_config(updated_config))

    async def _update_function_code(self, function_name: str, request: Request) -> Response:
        await parse_json_body(request)  # consume body
        config = self._registry.get_config(function_name)
        if config is None:
            return _json_response(
                {
                    "Message": f"Function not found: {function_name}",
                    "Type": "ResourceNotFoundException",
                },
                404,
            )
        _logger.info("UpdateFunctionCode called for %s (no-op in local dev)", function_name)
        return _json_response(_format_function_config(config))

    # -- Invocations ---------------------------------------------------------

    async def _invoke_function(self, function_name: str, request: Request) -> Response:
        compute = self._registry.get_compute(function_name)
        if compute is None:
            return _json_response(
                {
                    "Message": f"Function not found: {function_name}",
                    "Type": "ResourceNotFoundException",
                },
                404,
            )

        body = await parse_json_body(request)
        context = build_default_lambda_context(function_name)

        result = await compute.invoke(body, context)

        if result.error:
            return _json_response({"errorMessage": result.error}, 200)

        payload = result.payload if result.payload is not None else {}
        return _json_response(payload)

    # -- Permissions (stubs) -------------------------------------------------

    async def _add_permission(self, function_name: str, request: Request) -> Response:
        body = await parse_json_body(request)
        sid = body.get("StatementId", str(uuid.uuid4())[:8])
        self._state.permissions.setdefault(function_name, {})[sid] = body
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

    async def _get_policy(self, function_name: str) -> Response:
        perms = self._state.permissions.get(function_name, {})
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

    async def _remove_permission(self, function_name: str, sid: str) -> Response:
        self._state.permissions.get(function_name, {}).pop(sid, None)
        return Response(status_code=204)

    # -- Event source mappings (stubs) ---------------------------------------

    async def _create_event_source_mapping(self, request: Request) -> Response:
        body = await parse_json_body(request)
        esm_uuid = str(uuid.uuid4())
        mapping = {
            "UUID": esm_uuid,
            "EventSourceArn": body.get("EventSourceArn", ""),
            "FunctionArn": body.get("FunctionName", ""),
            "State": "Enabled",
            "BatchSize": body.get("BatchSize", 10),
        }
        self._state.event_source_mappings[esm_uuid] = mapping
        return _json_response(mapping, 202)

    async def _get_event_source_mapping(self, esm_uuid: str) -> Response:
        mapping = self._state.event_source_mappings.get(esm_uuid)
        if mapping is None:
            return _json_response({"Message": "Not found"}, 404)
        return _json_response(mapping)

    async def _delete_event_source_mapping(self, esm_uuid: str) -> Response:
        mapping = self._state.event_source_mappings.pop(esm_uuid, None)
        if mapping is None:
            return _json_response({"Message": "Not found"}, 404)
        mapping["State"] = "Deleting"
        return _json_response(mapping, 202)

    async def _list_event_source_mappings(self, _request: Request) -> Response:
        mappings = list(self._state.event_source_mappings.values())
        return _json_response({"EventSourceMappings": mappings})

    # -- Other stubs ---------------------------------------------------------

    async def _list_versions(self, function_name: str) -> Response:
        config = self._registry.get_config(function_name)
        if config is None:
            return _json_response(
                {
                    "Message": f"Function not found: {function_name}",
                    "Type": "ResourceNotFoundException",
                },
                404,
            )
        return _json_response({"Versions": [_format_function_config(config)]})

    async def _get_code_signing_config(self, function_name: str) -> Response:
        return _json_response({"CodeSigningConfigArn": "", "FunctionName": function_name})

    async def _tag_resource(self, arn: str, request: Request) -> Response:
        body = await parse_json_body(request)
        tags = body.get("Tags", {})
        self._registry.tag_resource(arn, tags)
        _logger.info("Tagged resource %s with %d tags", arn, len(tags))
        return Response(status_code=204)

    async def _untag_resource(self, arn: str, request: Request) -> Response:
        tag_keys_param = request.query_params.get("tagKeys", "")
        tag_keys = [k for k in tag_keys_param.split(",") if k]
        self._registry.untag_resource(arn, tag_keys)
        _logger.info("Untagged resource %s, removed keys: %s", arn, tag_keys)
        return Response(status_code=204)

    async def _list_tags(self, arn: str) -> Response:
        tags = self._registry.get_tags(arn)
        return _json_response({"Tags": tags})

    async def _stub_handler(self, request: Request, path: str) -> Response:
        _logger.warning("Unknown Lambda path: %s %s", request.method, path)
        return _json_response(
            {"Message": f"lws: Lambda has no route for {request.method} /{path}"},
            404,
        )

    # -- Compute creation ----------------------------------------------------

    def _create_compute(self, func_config: dict[str, Any]) -> Any:
        """Create an ICompute provider from the function configuration."""
        from lws.interfaces import ComputeConfig  # pylint: disable=import-outside-toplevel
        from lws.providers.lambda_runtime.docker import (  # pylint: disable=import-outside-toplevel
            DockerCompute,
        )

        function_name = func_config["FunctionName"]
        runtime = func_config.get("Runtime", "nodejs18.x")
        handler = func_config.get("Handler", "index.handler")
        timeout = func_config.get("Timeout", 3)
        memory_size = func_config.get("MemorySize", 128)

        # Get environment variables from the function config
        env_vars = func_config.get("Environment", {}).get("Variables", {})

        # Resolve code path
        code_info = func_config.get("Code", {})
        filename = code_info.get("S3Key") or code_info.get("Filename")
        code_path = _resolve_code_path(filename, self._project_dir)

        # If no code path from filename (e.g. Terraform sends ZipFile bytes),
        # try to find source dir from the function name
        if code_path is None and self._project_dir is not None:
            code_path = _resolve_code_path_from_name(function_name, self._project_dir)

        if code_path is None:
            code_path = Path(".")
            _logger.warning("Could not resolve code path for %s, using cwd", function_name)

        compute_config = ComputeConfig(
            function_name=function_name,
            handler=handler,
            runtime=runtime,
            code_path=code_path,
            timeout=timeout,
            memory_size=memory_size,
            environment=env_vars,
        )

        return DockerCompute(config=compute_config, sdk_env=self._sdk_env)


# ---------------------------------------------------------------------------
# App factory
# ---------------------------------------------------------------------------


def create_lambda_management_app(
    registry: LambdaRegistry | None = None,
    project_dir: Path | None = None,
    sdk_env: dict[str, str] | None = None,
) -> FastAPI:
    """Create a FastAPI app that speaks the Lambda management protocol."""
    if registry is None:
        registry = LambdaRegistry()
    app = FastAPI(title="LDK Lambda Management")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="lambda-mgmt")
    router = LambdaManagementRouter(registry, project_dir=project_dir, sdk_env=sdk_env)
    app.include_router(router.router)
    return app
