"""Step Functions helper functions for request parsing and response formatting."""

from __future__ import annotations

import json
import uuid
from typing import Any

from fastapi import Response


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


def check_sm_lifecycle(
    resource_arn: str,
    tracker: object,
    provider: object,
) -> Response | None:
    """Return error response if SM is not in ACTIVE state (CREATING or DELETING)."""
    sm_name = resource_arn.rsplit(":", 1)[-1] if ":" in resource_arn else resource_arn
    lc_status = tracker.get_state(sm_name)  # type: ignore[union-attr]
    if lc_status == "DELETING":
        return _error_response(
            "StateMachineDoesNotExist",
            f"Resource not found: {resource_arn}",
        )
    if lc_status == "CREATING":
        return _error_response(
            "StateMachineDeleting",
            f"State machine is not ACTIVE: {resource_arn}",
        )
    if sm_name not in provider.list_state_machines():  # type: ignore[union-attr]
        return _error_response(
            "ResourceNotFoundException",
            f"Resource not found: {resource_arn}",
        )
    return None
