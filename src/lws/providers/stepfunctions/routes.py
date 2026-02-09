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
        body = await _parse_request_body(request)
        action = _resolve_action(target, body)

        handler = self._handlers().get(action)
        if handler is None:
            return _error_response("UnknownAction", f"Unknown action: {action}")
        return await handler(body)

    def _handlers(self) -> dict:
        """Return map of action names to handler methods."""
        return {
            "StartExecution": self._start_execution,
            "StartSyncExecution": self._start_sync_execution,
            "DescribeExecution": self._describe_execution,
            "ListExecutions": self._list_executions,
            "ListStateMachines": self._list_state_machines,
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

    async def _list_state_machines(self, body: dict) -> Response:
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


# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------


async def _parse_request_body(request: Request) -> dict:
    """Parse the JSON request body."""
    body_bytes = await request.body()
    if not body_bytes:
        return {}
    try:
        return json.loads(body_bytes)
    except json.JSONDecodeError:
        return {}


def _resolve_action(target: str, body: dict) -> str:
    """Resolve the API action from the target header or body."""
    if target:
        # X-Amz-Target format: AWSStepFunctions.StartExecution
        return target.rsplit(".", 1)[-1] if "." in target else target
    return body.get("Action", "")


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
            f"arn:aws:states:us-east-1:000000000000" f":stateMachine:{history.state_machine_name}"
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


def create_stepfunctions_app(provider: StepFunctionsProvider) -> FastAPI:
    """Create a FastAPI application that speaks the Step Functions wire protocol."""
    app = FastAPI()
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="stepfunctions")
    sfn_router = StepFunctionsRouter(provider)
    app.include_router(sfn_router.router)
    return app
