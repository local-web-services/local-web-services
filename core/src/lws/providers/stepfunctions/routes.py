"""Step Functions HTTP routes.

Implements the Step Functions wire protocol that AWS SDKs expect,
using JSON request/response format with X-Amz-Target header dispatch.
"""

from __future__ import annotations

import json
import uuid
from typing import Any

from fastapi import APIRouter, FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers._shared.aws_iam_auth import IamAuthBundle, add_iam_auth_middleware
from lws.providers._shared.aws_operation_mock import AwsMockConfig, AwsOperationMockMiddleware
from lws.providers._shared.request_helpers import parse_json_body, resolve_api_action
from lws.providers.stepfunctions.provider import StepFunctionsProvider

_logger = get_logger("ldk.stepfunctions")


class StepFunctionsRouter:
    """Route Step Functions API requests to a StepFunctionsProvider backend."""

    def __init__(self, provider: StepFunctionsProvider) -> None:
        self.provider = provider
        self.router = APIRouter()
        self.router.add_api_route("/", self._dispatch, methods=["POST"])

    async def _dispatch(self, request: Request) -> Response:
        """Dispatch based on X-Amz-Target header or Action parameter."""
        target = request.headers.get("x-amz-target", "")
        body = await parse_json_body(request)
        action = resolve_api_action(target, body)

        handler = self._handlers().get(action)
        if handler is None:
            _logger.warning("Unknown Step Functions action: %s", action)
            return _error_response(
                "UnknownOperationException",
                f"lws: StepFunctions operation '{action}' is not yet implemented",
            )
        return await handler(body)

    def _handlers(self) -> dict:
        """Return map of action names to handler methods."""
        return {
            "StartExecution": self._start_execution,
            "StartSyncExecution": self._start_sync_execution,
            "DescribeExecution": self._describe_execution,
            "ListExecutions": self._list_executions,
            "ListStateMachines": self._list_state_machines,
            "CreateStateMachine": self._create_state_machine,
            "DeleteStateMachine": self._delete_state_machine,
            "DescribeStateMachine": self._describe_state_machine,
            "StopExecution": self._stop_execution,
            "UpdateStateMachine": self._update_state_machine,
            "GetExecutionHistory": self._get_execution_history,
            "ValidateStateMachineDefinition": self._validate_definition,
            "ListStateMachineVersions": self._list_state_machine_versions,
            "TagResource": self._tag_resource,
            "UntagResource": self._untag_resource,
            "ListTagsForResource": self._list_tags_for_resource,
        }

    # ------------------------------------------------------------------
    # Action handlers
    # ------------------------------------------------------------------

    async def _start_execution(self, body: dict) -> Response:
        """Handle StartExecution API action."""
        sm_name = _extract_state_machine_name(body)
        input_data = _parse_input(body)
        execution_name = body.get("name")

        try:
            result = await self.provider.start_execution(
                state_machine_name=sm_name,
                input_data=input_data,
                execution_name=execution_name,
            )
        except KeyError as exc:
            return _error_response("StateMachineDoesNotExist", str(exc))

        return _json_response(result)

    async def _start_sync_execution(self, body: dict) -> Response:
        """Handle StartSyncExecution API action (Express workflows)."""
        sm_name = _extract_state_machine_name(body)
        input_data = _parse_input(body)
        execution_name = body.get("name")

        try:
            result = await self.provider.start_execution(
                state_machine_name=sm_name,
                input_data=input_data,
                execution_name=execution_name,
            )
        except KeyError as exc:
            return _error_response("StateMachineDoesNotExist", str(exc))

        return _json_response(result)

    async def _describe_execution(self, body: dict) -> Response:
        """Handle DescribeExecution API action."""
        execution_arn = body.get("executionArn", "")
        history = self.provider.get_execution(execution_arn)
        if history is None:
            return _error_response("ExecutionDoesNotExist", f"Execution not found: {execution_arn}")
        return _json_response(_format_execution(history))

    async def _list_executions(self, body: dict) -> Response:
        """Handle ListExecutions API action."""
        sm_arn = body.get("stateMachineArn", "")
        sm_name = sm_arn.rsplit(":", 1)[-1] if ":" in sm_arn else sm_arn
        executions = self.provider.list_executions(sm_name or None)
        items = [_format_execution_summary(h) for h in executions]
        return _json_response({"executions": items})

    async def _list_state_machines(self, _body: dict) -> Response:
        """Handle ListStateMachines API action."""
        names = self.provider.list_state_machines()
        machines = [
            {
                "name": n,
                "stateMachineArn": f"arn:aws:states:us-east-1:000000000000:stateMachine:{n}",
            }
            for n in names
        ]
        return _json_response({"stateMachines": machines})

    async def _create_state_machine(self, body: dict) -> Response:
        """Handle CreateStateMachine API action."""
        name = body.get("name", "")
        definition = body.get("definition", "{}")
        role_arn = body.get("roleArn", "")
        sm_type = body.get("type", "STANDARD")

        if not name:
            return _error_response("ValidationException", "name is required")

        arn = self.provider.create_state_machine(
            name=name,
            definition=definition,
            role_arn=role_arn,
            workflow_type=sm_type,
        )
        return _json_response(
            {
                "stateMachineArn": arn,
                "creationDate": __import__("time").time(),
            }
        )

    async def _delete_state_machine(self, body: dict) -> Response:
        """Handle DeleteStateMachine API action."""
        sm_arn = body.get("stateMachineArn", "")
        sm_name = sm_arn.rsplit(":", 1)[-1] if ":" in sm_arn else sm_arn

        try:
            self.provider.delete_state_machine(sm_name)
        except KeyError:
            return _error_response(
                "StateMachineDoesNotExist",
                f"State machine not found: {sm_arn}",
            )
        return _json_response({})

    async def _describe_state_machine(self, body: dict) -> Response:
        """Handle DescribeStateMachine API action."""
        sm_arn = body.get("stateMachineArn", "")
        sm_name = sm_arn.rsplit(":", 1)[-1] if ":" in sm_arn else sm_arn

        try:
            attrs = self.provider.describe_state_machine(sm_name)
        except KeyError:
            return _error_response(
                "StateMachineDoesNotExist",
                f"State machine not found: {sm_arn}",
            )
        return _json_response(attrs)

    async def _validate_definition(self, _body: dict) -> Response:
        """Handle ValidateStateMachineDefinition — always valid."""
        return _json_response({"result": "OK", "diagnostics": []})

    async def _list_state_machine_versions(self, _body: dict) -> Response:
        return _json_response({"stateMachineVersions": []})

    async def _tag_resource(self, body: dict) -> Response:
        resource_arn = body.get("resourceArn", "")
        tags = body.get("tags", [])
        self.provider.tag_resource(resource_arn, tags)
        return _json_response({})

    async def _untag_resource(self, body: dict) -> Response:
        resource_arn = body.get("resourceArn", "")
        tag_keys = body.get("tagKeys", [])
        self.provider.untag_resource(resource_arn, tag_keys)
        return _json_response({})

    async def _list_tags_for_resource(self, body: dict) -> Response:
        resource_arn = body.get("resourceArn", "")
        tags = self.provider.list_tags_for_resource(resource_arn)
        return _json_response({"tags": tags})

    async def _stop_execution(self, body: dict) -> Response:
        """Handle StopExecution API action."""
        execution_arn = body.get("executionArn", "")
        error = body.get("error")
        cause = body.get("cause")

        try:
            self.provider.stop_execution(
                execution_arn=execution_arn,
                error=error,
                cause=cause,
            )
        except KeyError:
            return _error_response(
                "ExecutionDoesNotExist",
                f"Execution not found: {execution_arn}",
            )
        return _json_response({"stopDate": __import__("time").time()})

    async def _update_state_machine(self, body: dict) -> Response:
        """Handle UpdateStateMachine API action."""
        sm_arn = body.get("stateMachineArn", "")
        sm_name = sm_arn.rsplit(":", 1)[-1] if ":" in sm_arn else sm_arn
        definition = body.get("definition")
        role_arn = body.get("roleArn")

        try:
            update_date = self.provider.update_state_machine(
                name=sm_name,
                definition=definition,
                role_arn=role_arn,
            )
        except KeyError:
            return _error_response(
                "StateMachineDoesNotExist",
                f"State machine not found: {sm_arn}",
            )
        return _json_response({"updateDate": update_date})

    async def _get_execution_history(self, body: dict) -> Response:
        """Handle GetExecutionHistory API action."""
        execution_arn = body.get("executionArn", "")
        max_results = body.get("maxResults")

        try:
            events = self.provider.get_execution_history(
                execution_arn=execution_arn,
                max_results=max_results,
            )
        except KeyError:
            return _error_response(
                "ExecutionDoesNotExist",
                f"Execution not found: {execution_arn}",
            )
        return _json_response({"events": events})


# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------


def _extract_state_machine_name(body: dict) -> str:
    """Extract the state machine name from request body."""
    sm_arn = body.get("stateMachineArn", "")
    if ":" in sm_arn:
        return sm_arn.rsplit(":", 1)[-1]
    return sm_arn or body.get("name", "")


def _parse_input(body: dict) -> dict | None:
    """Parse the input field from the request body."""
    input_str = body.get("input")
    if input_str is None:
        return None
    if isinstance(input_str, str):
        try:
            return json.loads(input_str)
        except json.JSONDecodeError:
            return {"raw": input_str}
    return input_str


def _format_execution(history: Any) -> dict:
    """Format an ExecutionHistory into a DescribeExecution response."""
    result: dict[str, Any] = {
        "executionArn": history.execution_arn,
        "stateMachineArn": (
            f"arn:aws:states:us-east-1:000000000000:stateMachine:{history.state_machine_name}"
        ),
        "name": history.execution_arn.rsplit(":", 1)[-1],
        "status": history.status.value,
        "startDate": history.start_time,
    }
    if history.end_time is not None:
        result["stopDate"] = history.end_time
    if history.output_data is not None:
        result["output"] = json.dumps(history.output_data)
    if history.error:
        result["error"] = history.error
    if history.cause:
        result["cause"] = history.cause
    return result


def _format_execution_summary(history: Any) -> dict:
    """Format an ExecutionHistory into a list execution summary."""
    return {
        "executionArn": history.execution_arn,
        "name": history.execution_arn.rsplit(":", 1)[-1],
        "status": history.status.value,
        "startDate": history.start_time,
    }


def _json_response(data: dict, status_code: int = 200) -> Response:
    """Return a JSON response."""
    return Response(
        content=json.dumps(data, default=str),
        status_code=status_code,
        media_type="application/json",
    )


def _error_response(code: str, message: str, status_code: int = 400) -> Response:
    """Return an error response in Step Functions format."""
    error_body = {
        "__type": code,
        "message": message,
        "requestId": str(uuid.uuid4()),
    }
    return _json_response(error_body, status_code=status_code)


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_stepfunctions_app(
    provider: StepFunctionsProvider,
    chaos: AwsChaosConfig | None = None,
    aws_mock: AwsMockConfig | None = None,
    iam_auth: IamAuthBundle | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the Step Functions wire protocol."""
    app = FastAPI()
    if aws_mock is not None:
        app.add_middleware(
            AwsOperationMockMiddleware, mock_config=aws_mock, service="stepfunctions"
        )
    add_iam_auth_middleware(app, "stepfunctions", iam_auth, ErrorFormat.JSON)
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="stepfunctions")
    sfn_router = StepFunctionsRouter(provider)
    app.include_router(sfn_router.router)
    return app
