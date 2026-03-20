"""Lambda management HTTP routes.

Implements the Lambda REST management API that the AWS SDK and Terraform
use to create/read/delete Lambda functions and invoke them.

Also provides ``LambdaRegistry``, a shared registry of function name ->
``ICompute`` instances used by both this module and the API Gateway V2
proxy to invoke Lambda functions.
"""

from __future__ import annotations

from pathlib import Path
from typing import Any

from fastapi import APIRouter, FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.lambda_helpers import build_default_lambda_context
from lws.providers._shared.request_helpers import parse_json_body
from lws.providers.lambda_runtime._lambda_esm_ops import (
    handle_create_event_source_mapping,
    handle_delete_event_source_mapping,
    handle_get_event_source_mapping,
    handle_list_event_source_mappings,
)
from lws.providers.lambda_runtime._lambda_function_ops import (
    _function_arn,
    _json_response,
    handle_add_permission,
    handle_create_function,
    handle_delete_function,
    handle_get_code_signing_config,
    handle_get_function,
    handle_get_policy,
    handle_list_functions,
    handle_list_tags,
    handle_list_versions,
    handle_remove_permission,
    handle_tag_resource,
    handle_untag_resource,
    handle_update_function_code,
    handle_update_function_configuration,
    resolve_code_path,
    resolve_code_path_from_name,
)
from lws.providers.lambda_runtime._lambda_registry import LambdaRegistry

_logger = get_logger("ldk.lambda-mgmt")

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"

# Re-export with original underscore-prefixed names for backward compatibility
_resolve_code_path = resolve_code_path
_resolve_code_path_from_name = resolve_code_path_from_name



class _LambdaState:
    def __init__(self) -> None:
        self.event_source_mappings: dict[str, dict[str, Any]] = {}
        self.permissions: dict[str, dict[str, Any]] = {}


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
        lifecycle: ResourceLifecycleConfig | None = None,
        capacity: AwsCapacityConfig | None = None,
    ) -> None:
        self._registry = registry
        self._project_dir = project_dir
        self._sdk_env = sdk_env or {}
        self._state = _LambdaState()
        _lc = lifecycle or ResourceLifecycleConfig()
        self._lifecycle = _lc
        self._tracker = ResourceStateTracker(_lc)
        self._capacity = capacity or AwsCapacityConfig()
        self.router = APIRouter()
        self._register_routes()

    def _register_routes(self) -> None:
        r = self.router

        r.add_api_route("/2015-03-31/functions", self._create_function, methods=["POST"])
        r.add_api_route("/2015-03-31/functions", self._list_functions, methods=["GET"])
        r.add_api_route(
            "/2015-03-31/functions/{function_name}", self._get_function, methods=["GET"]
        )
        r.add_api_route(
            "/2015-03-31/functions/{function_name}", self._delete_function, methods=["DELETE"]
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
        r.add_api_route(
            "/2015-03-31/functions/{function_name}/invocations",
            self._invoke_function,
            methods=["POST"],
        )
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
        r.add_api_route(
            "/2015-03-31/functions/{function_name}/versions",
            self._list_versions,
            methods=["GET"],
        )
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
        r.add_api_route(
            "/2021-10-31/functions/{function_name}/url",
            self._create_function_url_config,
            methods=["POST"],
        )
        r.add_api_route(
            "/2021-10-31/functions/{function_name}/url",
            self._get_function_url_config,
            methods=["GET"],
        )
        r.add_api_route(
            "/2021-10-31/functions/{function_name}/url",
            self._update_function_url_config,
            methods=["PUT"],
        )
        r.add_api_route(
            "/2021-10-31/functions/{function_name}/url",
            self._delete_function_url_config,
            methods=["DELETE"],
        )
        r.add_api_route("/2017-03-31/tags/{arn:path}", self._tag_resource, methods=["POST"])
        r.add_api_route("/2017-03-31/tags/{arn:path}", self._untag_resource, methods=["DELETE"])
        r.add_api_route("/2017-03-31/tags/{arn:path}", self._list_tags, methods=["GET"])
        r.add_api_route("/2015-03-31/tags/{arn:path}", self._tag_resource, methods=["POST"])
        r.add_api_route("/2015-03-31/tags/{arn:path}", self._untag_resource, methods=["DELETE"])
        r.add_api_route("/2015-03-31/tags/{arn:path}", self._list_tags, methods=["GET"])
        r.add_api_route(
            "/{path:path}",
            self._stub_handler,
            methods=["GET", "POST", "PUT", "PATCH", "DELETE"],
        )

    # -- Functions -----------------------------------------------------------

    async def _create_function(self, request: Request) -> Response:
        return await handle_create_function(
            request,
            self._registry,
            self._create_compute,
            self._lifecycle,
            self._tracker,
        )

    async def _list_functions(self, _request: Request) -> Response:
        return await handle_list_functions(self._registry)

    async def _get_function(self, function_name: str) -> Response:
        return await handle_get_function(
            function_name, self._registry, self._lifecycle, self._tracker
        )

    async def _delete_function(self, function_name: str) -> Response:
        return await handle_delete_function(
            function_name, self._registry, self._lifecycle, self._tracker
        )

    async def _update_function_configuration(
        self, function_name: str, request: Request
    ) -> Response:
        return await handle_update_function_configuration(
            function_name, request, self._registry, self._lifecycle, self._tracker
        )

    async def _update_function_code(self, function_name: str, request: Request) -> Response:
        return await handle_update_function_code(
            function_name, request, self._registry, self._lifecycle, self._tracker
        )

    # -- Invocations ---------------------------------------------------------

    async def _invoke_function(self, function_name: str, request: Request) -> Response:
        if self._capacity.is_exhausted:
            return _json_response(
                {
                    "Message": "lws: no invocation slots available",
                    "Type": "ServiceUnavailableException",
                },
                503,
            )
        compute = self._registry.get_compute(function_name)
        if compute is None:
            return _json_response(
                {
                    "Message": f"Function not found: {function_name}",
                    "Type": "ResourceNotFoundException",
                },
                404,
            )
        if self._lifecycle.enabled:
            state = self._tracker.get_state(function_name)
            if state in ("CREATING", "DELETING"):
                return _json_response(
                    {
                        "Message": f"Function {function_name} is in state {state}",
                        "Type": "ResourceConflictException",
                    },
                    409,
                )

        body = await parse_json_body(request)
        context = build_default_lambda_context(function_name)
        result = await compute.invoke(body, context)

        if result.error:
            return _json_response({"errorMessage": result.error}, 200)

        payload = result.payload if result.payload is not None else {}
        return _json_response(payload)

    # -- Permissions ---------------------------------------------------------

    async def _add_permission(self, function_name: str, request: Request) -> Response:
        return await handle_add_permission(function_name, request, self._state.permissions)

    async def _get_policy(self, function_name: str) -> Response:
        return await handle_get_policy(function_name, self._state.permissions)

    async def _remove_permission(self, function_name: str, sid: str) -> Response:
        return await handle_remove_permission(function_name, sid, self._state.permissions)

    # -- Event source mappings -----------------------------------------------

    async def _create_event_source_mapping(self, request: Request) -> Response:
        return await handle_create_event_source_mapping(request, self._state.event_source_mappings)

    async def _get_event_source_mapping(self, esm_uuid: str) -> Response:
        return await handle_get_event_source_mapping(esm_uuid, self._state.event_source_mappings)

    async def _delete_event_source_mapping(self, esm_uuid: str) -> Response:
        return await handle_delete_event_source_mapping(esm_uuid, self._state.event_source_mappings)

    async def _list_event_source_mappings(self, _request: Request) -> Response:
        return await handle_list_event_source_mappings(self._state.event_source_mappings)

    # -- Other stubs ---------------------------------------------------------

    async def _list_versions(self, function_name: str) -> Response:
        return await handle_list_versions(function_name, self._registry)

    async def _get_code_signing_config(self, function_name: str) -> Response:
        return await handle_get_code_signing_config(function_name)

    async def _tag_resource(self, arn: str, request: Request) -> Response:
        return await handle_tag_resource(arn, request, self._registry)

    async def _untag_resource(self, arn: str, request: Request) -> Response:
        return await handle_untag_resource(arn, request, self._registry)

    async def _list_tags(self, arn: str) -> Response:
        return await handle_list_tags(arn, self._registry)

    # -- Function URLs -------------------------------------------------------

    async def _create_function_url_config(self, function_name: str, request: Request) -> Response:
        body = await parse_json_body(request)
        if self._registry.get_function_url(function_name) is not None:
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

        compute = self._registry.get_compute(function_name)
        if compute is not None:
            port = self._allocate_function_url_port()
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
                self._registry.register_function_url(function_name, url_config, provider)
            except Exception as exc:
                _logger.error("Failed to start Function URL for %s: %s", function_name, exc)
                self._registry.register_function_url(function_name, url_config)
        else:
            self._registry.register_function_url(function_name, url_config)

        _logger.info("Created Function URL for %s", function_name)
        return _json_response(url_config, 201)

    async def _get_function_url_config(self, function_name: str) -> Response:
        url_config = self._registry.get_function_url(function_name)
        if url_config is None:
            return _json_response(
                {
                    "Message": f"Function URL config not found for: {function_name}",
                    "Type": "ResourceNotFoundException",
                },
                404,
            )
        return _json_response(url_config)

    async def _update_function_url_config(self, function_name: str, request: Request) -> Response:
        body = await parse_json_body(request)
        url_config = self._registry.get_function_url(function_name)
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

    async def _delete_function_url_config(self, function_name: str) -> Response:
        provider = self._registry.function_url_providers.get(function_name)
        if provider is not None:
            try:
                await provider.stop()
            except Exception as exc:
                _logger.warning(
                    "Error stopping Function URL provider for %s: %s", function_name, exc
                )
        self._registry.delete_function_url(function_name)
        return Response(status_code=204)

    def _allocate_function_url_port(self) -> int:
        """Allocate a dynamic port for a new Function URL provider."""
        base = 19100
        used = {cfg.get("_port", 0) for cfg in self._registry.function_urls.values()}
        port = base
        while port in used:
            port += 1
        return port

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
        env_vars = func_config.get("Environment", {}).get("Variables", {})
        code_info = func_config.get("Code", {})
        filename = code_info.get("S3Key") or code_info.get("Filename")
        code_path = resolve_code_path(filename, self._project_dir)

        if code_path is None and self._project_dir is not None:
            code_path = resolve_code_path_from_name(function_name, self._project_dir)

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
    lifecycle: ResourceLifecycleConfig | None = None,
    capacity: AwsCapacityConfig | None = None,
) -> FastAPI:
    """Create a FastAPI app that speaks the Lambda management protocol."""
    if registry is None:
        registry = LambdaRegistry()
    app = FastAPI(title="LDK Lambda Management")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="lambda-mgmt")
    router = LambdaManagementRouter(
        registry, project_dir=project_dir, sdk_env=sdk_env, lifecycle=lifecycle, capacity=capacity
    )
    app.include_router(router.router)
    return app
