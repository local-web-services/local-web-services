"""Lambda management HTTP routes."""

from __future__ import annotations

import asyncio
import uuid
from pathlib import Path
from typing import Any

from fastapi import APIRouter, FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_capacity import AwsCapacityConfig, check_capacity
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.lambda_helpers import build_default_lambda_context
from lws.providers._shared.request_helpers import parse_json_body
from lws.providers.lambda_runtime._lambda_compute_factory import create_compute
from lws.providers.lambda_runtime._lambda_esm_ops import (
    handle_create_event_source_mapping,
    handle_delete_event_source_mapping,
    handle_get_event_source_mapping,
    handle_list_event_source_mappings,
    handle_update_event_source_mapping,
)
from lws.providers.lambda_runtime._lambda_function_ops import (
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
    run_async_invocation,
)
from lws.providers.lambda_runtime._lambda_registry import LambdaRegistry
from lws.providers.lambda_runtime._lambda_state import (
    _LambdaState,
)
from lws.providers.lambda_runtime._lambda_url_ops import (
    handle_create_function_url_config,
    handle_delete_function_url_config,
    handle_get_function_url_config,
    handle_update_function_url_config,
)
from lws.providers.lambda_runtime.event_source_manager import EventSourceManager

_logger = get_logger("ldk.lambda-mgmt")


class LambdaManagementRouter:
    """Route Lambda management requests."""

    def __init__(
        self,
        registry: LambdaRegistry,
        project_dir: Path | None = None,
        sdk_env: dict[str, str] | None = None,
        lifecycle: ResourceLifecycleConfig | None = None,
        capacity: AwsCapacityConfig | None = None,
        async_capacity: AwsCapacityConfig | None = None,
        event_source_manager: EventSourceManager | None = None,
        dynamodb_provider: Any = None,
        dynamodb_tracker_ref: list | None = None,
        tracker_ref: list | None = None,
    ) -> None:
        self._registry = registry
        self._project_dir = project_dir
        self._sdk_env = sdk_env or {}
        self._state = _LambdaState()
        _lc = lifecycle or ResourceLifecycleConfig()
        self._lifecycle = _lc
        self._tracker = ResourceStateTracker(_lc)
        if tracker_ref is not None:
            tracker_ref.append(self._tracker)
        self._capacity = capacity or AwsCapacityConfig()
        self._async_capacity = async_capacity or AwsCapacityConfig()
        self._event_source_manager = event_source_manager
        self._dynamodb_provider = dynamodb_provider
        self._dynamodb_tracker_ref = dynamodb_tracker_ref or []
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
            self._update_event_source_mapping,
            methods=["PUT"],
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
            "/2017-10-31/functions/{function_name}/concurrency",
            self._put_function_concurrency,
            methods=["PUT"],
        )
        r.add_api_route(
            "/lws/invocations/{invocation_id}",
            self._get_invocation_state,
            methods=["GET"],
        )
        r.add_api_route(
            "/lws/lambda/invocations/{function_name}",
            self._get_function_invocations,
            methods=["GET"],
        )
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
        capacity_err = check_capacity(self._capacity, "TooManyRequestsException", 429)
        if capacity_err is not None:
            return capacity_err
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

        invocation_type = request.headers.get("X-Amz-Invocation-Type", "RequestResponse")
        if invocation_type == "Event":
            async_capacity_err = check_capacity(
                self._async_capacity, "TooManyRequestsException", 429
            )
            if async_capacity_err is not None:
                return async_capacity_err
            invocation_id = str(uuid.uuid4())
            self._state.record_invocation(invocation_id, function_name)
            asyncio.create_task(
                run_async_invocation(
                    compute, body, context, invocation_id, self._state, function_name
                )
            )
            return Response(
                status_code=202,
                headers={"X-Amzn-RequestId": invocation_id},
            )

        invocation_id = str(uuid.uuid4())
        self._state.record_invocation(invocation_id, function_name)
        result = await compute.invoke(body, context)
        self._state.complete_invocation(invocation_id, success=not result.error)

        if result.error:
            return _json_response({"errorMessage": result.error}, 200)

        payload = result.payload if result.payload is not None else {}
        return _json_response(payload)

    # -- Permissions ---------------------------------------------------------

    async def _add_permission(self, function_name: str, request: Request) -> Response:
        return await handle_add_permission(
            function_name,
            request,
            self._state.permissions,
            self._registry,
            self._lifecycle,
            self._tracker,
        )

    async def _get_policy(self, function_name: str) -> Response:
        return await handle_get_policy(function_name, self._state.permissions)

    async def _remove_permission(self, function_name: str, sid: str) -> Response:
        return await handle_remove_permission(function_name, sid, self._state.permissions)

    # -- Event source mappings -----------------------------------------------

    async def _create_event_source_mapping(self, request: Request) -> Response:
        _dynamodb_tracker = self._dynamodb_tracker_ref[0] if self._dynamodb_tracker_ref else None
        response = await handle_create_event_source_mapping(
            request,
            self._state.event_source_mappings,
            dynamodb_provider=self._dynamodb_provider,
            dynamodb_tracker=_dynamodb_tracker,
        )
        if response.status_code in (200, 202) and self._event_source_manager is not None:
            import json  # pylint: disable=import-outside-toplevel

            body = json.loads(response.body)
            esm_uuid = body.get("UUID", "")
            mapping = self._state.event_source_mappings.get(esm_uuid)
            if mapping is not None:
                await self._event_source_manager.activate(mapping)
        return response

    async def _get_event_source_mapping(self, esm_uuid: str) -> Response:
        return await handle_get_event_source_mapping(esm_uuid, self._state.event_source_mappings)

    async def _delete_event_source_mapping(self, esm_uuid: str) -> Response:
        response = await handle_delete_event_source_mapping(
            esm_uuid, self._state.event_source_mappings
        )
        if self._event_source_manager is not None:
            await self._event_source_manager.deactivate(esm_uuid)
        return response

    async def _update_event_source_mapping(self, esm_uuid: str, request: Request) -> Response:
        return await handle_update_event_source_mapping(
            esm_uuid, request, self._state.event_source_mappings
        )

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
        return await handle_create_function_url_config(
            function_name, request, self._registry, self._allocate_function_url_port
        )

    async def _get_function_url_config(self, function_name: str) -> Response:
        return await handle_get_function_url_config(function_name, self._registry)

    async def _update_function_url_config(self, function_name: str, request: Request) -> Response:
        return await handle_update_function_url_config(function_name, request, self._registry)

    async def _delete_function_url_config(self, function_name: str) -> Response:
        return await handle_delete_function_url_config(function_name, self._registry)

    def _allocate_function_url_port(self) -> int:
        """Allocate a dynamic port for a new Function URL provider."""
        base = 19100
        used = {cfg.get("_port", 0) for cfg in self._registry.function_urls.values()}
        port = base
        while port in used:
            port += 1
        return port

    async def _put_function_concurrency(self, function_name: str, request: Request) -> Response:
        config = self._registry.get_config(function_name)
        if config is None:
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
        reserved = body.get("ReservedConcurrentExecutions", 0)
        return _json_response(
            {
                "FunctionName": function_name,
                "ReservedConcurrentExecutions": reserved,
            }
        )

    async def _get_invocation_state(self, invocation_id: str) -> Response:
        state = self._state.get_invocation_state(invocation_id)
        if state is None:
            return _json_response({"Message": f"Invocation not found: {invocation_id}"}, 404)
        return _json_response({"InvocationId": invocation_id, "State": state})

    async def _get_function_invocations(self, function_name: str) -> Response:
        records = self._state.get_function_invocations(function_name)
        return _json_response({"FunctionName": function_name, "Invocations": records})

    async def _stub_handler(self, request: Request, path: str) -> Response:
        _logger.warning("Unknown Lambda path: %s %s", request.method, path)
        return _json_response(
            {"Message": f"lws: Lambda has no route for {request.method} /{path}"},
            404,
        )

    # -- Compute creation ----------------------------------------------------

    def _create_compute(self, func_config: dict[str, Any]) -> Any:
        """Create an ICompute provider from the function configuration."""
        return create_compute(func_config, self._project_dir, self._sdk_env)


def create_lambda_management_app(
    registry: LambdaRegistry | None = None,
    project_dir: Path | None = None,
    sdk_env: dict[str, str] | None = None,
    lifecycle: ResourceLifecycleConfig | None = None,
    capacity: AwsCapacityConfig | None = None,
    async_capacity: AwsCapacityConfig | None = None,
    event_source_manager: EventSourceManager | None = None,
    dynamodb_provider: Any = None,
    dynamodb_tracker_ref: list | None = None,
    tracker_ref: list | None = None,
) -> FastAPI:
    """Create a FastAPI app that speaks the Lambda management protocol."""
    if registry is None:
        registry = LambdaRegistry()
    app = FastAPI(title="LDK Lambda Management")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="lambda-mgmt")
    router = LambdaManagementRouter(
        registry,
        project_dir=project_dir,
        sdk_env=sdk_env,
        lifecycle=lifecycle,
        capacity=capacity,
        async_capacity=async_capacity,
        event_source_manager=event_source_manager,
        dynamodb_provider=dynamodb_provider,
        dynamodb_tracker_ref=dynamodb_tracker_ref,
        tracker_ref=tracker_ref,
    )
    app.include_router(router.router)
    return app
