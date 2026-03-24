"""Helper functions and compute bridges for the StepFunctions provider.

Contains: definition resolution, ARN building, execution response building,
Lambda compute bridge, and cloud assembly parsing.
"""

from __future__ import annotations

import json
import time
import uuid
from enum import Enum
from typing import TYPE_CHECKING, Any

from lws.interfaces.compute import ICompute, InvocationResult, LambdaContext
from lws.providers.stepfunctions.engine import ExecutionHistory, ExecutionStatus

if TYPE_CHECKING:
    from lws.providers.stepfunctions.provider import StateMachineConfig


# ---------------------------------------------------------------------------
# Definition helpers
# ---------------------------------------------------------------------------


def _resolve_definition(config: StateMachineConfig) -> str | dict:
    """Resolve definition substitutions if present."""
    definition = config.definition
    if not config.definition_substitutions:
        return definition
    if isinstance(definition, dict):
        definition = json.dumps(definition)
    for placeholder, value in config.definition_substitutions.items():
        definition = definition.replace(f"${{{placeholder}}}", value)
    return definition


def _build_execution_arn(state_machine_name: str, execution_name: str) -> str:
    """Build a fake execution ARN."""
    return f"arn:aws:states:us-east-1:000000000000:execution:{state_machine_name}:{execution_name}"


# ---------------------------------------------------------------------------
# Response builders
# ---------------------------------------------------------------------------


def _build_sync_response(history: ExecutionHistory) -> dict:
    """Build the response dict for a synchronous (EXPRESS) execution."""
    response: dict[str, Any] = {
        "executionArn": history.execution_arn,
        "startDate": history.start_time,
        "status": history.status.value,
    }
    if history.status == ExecutionStatus.SUCCEEDED:
        response["output"] = json.dumps(history.output_data) if history.output_data else "{}"
    elif history.status == ExecutionStatus.FAILED:
        response["error"] = history.error
        response["cause"] = history.cause
    return response


def _build_async_response(execution_arn: str) -> dict:
    """Build the response dict for an asynchronous (STANDARD) execution."""
    return {
        "executionArn": execution_arn,
        "startDate": time.time(),
    }


def _build_terminal_event(history: ExecutionHistory, event_id: int) -> dict | None:
    """Build a terminal event dict for a completed execution, or None if still running."""
    timestamp = history.end_time or history.start_time
    base = {
        "timestamp": timestamp,
        "id": event_id,
        "previousEventId": event_id - 1,
    }
    if history.status == ExecutionStatus.SUCCEEDED:
        base["type"] = "ExecutionSucceeded"
        base["executionSucceededEventDetails"] = {
            "output": json.dumps(history.output_data) if history.output_data else "{}",
        }
        return base
    if history.status == ExecutionStatus.FAILED:
        base["type"] = "ExecutionFailed"
        base["executionFailedEventDetails"] = {
            "error": history.error or "",
            "cause": history.cause or "",
        }
        return base
    if history.status == ExecutionStatus.ABORTED:
        base["type"] = "ExecutionAborted"
        base["executionAbortedEventDetails"] = {
            "error": history.error or "",
            "cause": history.cause or "",
        }
        return base
    return None


# ---------------------------------------------------------------------------
# Lambda compute bridge utilities
# ---------------------------------------------------------------------------


def _extract_function_name(resource_arn: str) -> str:
    """Extract the function name from a Lambda ARN or resource string."""
    if ":function:" in resource_arn:
        return resource_arn.split(":function:")[-1].split(":")[0]
    # LDK-style ARN: arn:ldk:lambda:local:000000000000:function/Name
    if "function/" in resource_arn:
        return resource_arn.split("function/")[-1].split(":")[0]
    # For simple names / aliases
    return resource_arn.rsplit(":", 1)[-1] if ":" in resource_arn else resource_arn


def _find_provider_by_arn(providers: dict[str, ICompute], arn: str) -> ICompute | None:
    """Try to find a compute provider by matching the ARN against provider keys."""
    for key, provider in providers.items():
        if key in arn or arn.endswith(key):
            return provider
    return None


async def _invoke_compute(compute: ICompute, function_name: str, payload: Any) -> InvocationResult:
    """Invoke a compute provider with the given payload."""
    context = LambdaContext(
        function_name=function_name,
        memory_limit_in_mb=128,
        timeout_seconds=300,
        aws_request_id=str(uuid.uuid4()),
        invoked_function_arn=f"arn:aws:lambda:us-east-1:000000000000:function:{function_name}",
    )
    event = payload if isinstance(payload, dict) else {"input": payload}
    return await compute.invoke(event, context)


def _process_invocation_result(result: InvocationResult, _resource_arn: str) -> Any:
    """Process an InvocationResult, raising on error."""
    if result.error:
        from lws.providers.stepfunctions.engine import (  # pylint: disable=import-outside-toplevel
            StatesTaskFailed,
        )

        raise StatesTaskFailed(
            error="States.TaskFailed",
            cause=result.error,
        )
    return result.payload


# ---------------------------------------------------------------------------
# Lambda compute bridge
# ---------------------------------------------------------------------------


class LambdaComputeBridge:
    """Bridges ICompute providers to the ComputeInvoker protocol.

    Resolves Lambda ARNs from Task state Resource fields to local
    compute handlers.
    """

    def __init__(self, compute_providers: dict[str, ICompute]) -> None:
        self._providers = compute_providers

    async def invoke_function(self, resource_arn: str, payload: Any) -> Any:
        """Invoke a Lambda function by resolving its resource ARN."""
        # Handle SFN service integration: arn:...:states:::lambda:invoke
        if "lambda:invoke" in resource_arn and isinstance(payload, dict):
            fn_ref = payload.get("FunctionName", "")
            actual_payload = payload.get("Payload", payload)
            function_name = _extract_function_name(fn_ref)
            compute = self._providers.get(function_name)
            if compute is None:
                compute = _find_provider_by_arn(self._providers, fn_ref)
            if compute is None:
                raise RuntimeError(f"No compute provider for: {fn_ref}")
            result = await _invoke_compute(compute, function_name, actual_payload)
            inner = _process_invocation_result(result, resource_arn)
            # Wrap in service integration envelope (matches real AWS behaviour)
            return {"Payload": inner, "StatusCode": 200}

        function_name = _extract_function_name(resource_arn)
        compute = self._providers.get(function_name)
        if compute is None:
            compute = _find_provider_by_arn(self._providers, resource_arn)
        if compute is None:
            raise RuntimeError(f"No compute provider for: {resource_arn}")

        result = await _invoke_compute(compute, function_name, payload)
        return _process_invocation_result(result, resource_arn)


# ---------------------------------------------------------------------------
# Cloud Assembly parsing helpers (P2-17)
# ---------------------------------------------------------------------------


class _WorkflowTypeParser:
    """Parses workflow type strings without importing the provider enum directly."""

    _EXPRESS = "EXPRESS"
    _STANDARD = "STANDARD"

    @staticmethod
    def parse(type_str: str, workflow_type_enum: type[Enum]) -> Enum:
        """Parse a workflow type string into the provided enum."""
        try:
            return workflow_type_enum(type_str.upper())
        except ValueError:
            return workflow_type_enum(_WorkflowTypeParser._STANDARD)


def _apply_assembly_substitutions(definition_string: str, substitutions: dict[str, str]) -> str:
    """Apply DefinitionSubstitutions to the definition string."""
    if isinstance(definition_string, dict):
        definition_string = json.dumps(definition_string)
    for key, value in substitutions.items():
        definition_string = definition_string.replace(f"${{{key}}}", str(value))
    return definition_string


def _remap_lambda_arns(definition: str, mapping: dict[str, str]) -> str:
    """Replace Lambda ARNs in a definition string with local function names."""
    for arn, local_name in mapping.items():
        definition = definition.replace(arn, local_name)
    return definition


def _build_execution_history_events(
    history: ExecutionHistory,
    max_results: int | None = None,
) -> list[dict]:
    """Build a list of execution history event dicts for a completed or running execution."""
    events: list[dict] = []

    # Always include an ExecutionStarted event
    events.append(
        {
            "timestamp": history.start_time,
            "type": "ExecutionStarted",
            "id": 1,
            "previousEventId": 0,
            "executionStartedEventDetails": {
                "input": json.dumps(history.input_data) if history.input_data else "{}",
                "roleArn": "",
            },
        }
    )

    # Add state transition events
    event_id = 2
    for transition in history.transitions:
        events.append(
            {
                "timestamp": transition.timestamp,
                "type": "StateEntered",
                "id": event_id,
                "previousEventId": event_id - 1,
                "stateEnteredEventDetails": {
                    "name": transition.state_name,
                    "input": (json.dumps(transition.input_data) if transition.input_data else "{}"),
                },
            }
        )
        event_id += 1

    # Add terminal event if execution has completed
    terminal = _build_terminal_event(history, event_id)
    if terminal is not None:
        events.append(terminal)

    if max_results is not None:
        events = events[:max_results]

    return events


# ---------------------------------------------------------------------------
# State machine description builder
# ---------------------------------------------------------------------------


def _build_state_machine_description(
    name: str,
    configs: dict,
    workflow_types: dict,
    workflow_type_standard: object,
) -> dict:
    """Build an AWS-compatible describe_state_machine response dict."""
    config = configs.get(name)
    wf_type = workflow_types.get(name, workflow_type_standard)
    definition = ""
    if config:
        raw = config.definition
        definition = json.dumps(raw) if isinstance(raw, dict) else str(raw)
    return {
        "name": name,
        "stateMachineArn": f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}",
        "definition": definition,
        "type": wf_type.value,
        "roleArn": config.role_arn if config else "",
        "status": "ACTIVE",
        "creationDate": time.time(),
    }


# ---------------------------------------------------------------------------
# Cloud assembly parsing entry point
# ---------------------------------------------------------------------------


def _parse_cloud_assembly_config(
    logical_id: str,
    resource_properties: dict,
    resource_mapping: dict | None,
    state_machine_config_class: type,
    workflow_type_enum: type,
) -> object:
    """Parse cloud assembly properties into a StateMachineConfig.

    Parameters
    ----------
    logical_id:
        The CloudFormation logical ID.
    resource_properties:
        The Properties dict from the CloudFormation resource.
    resource_mapping:
        Optional mapping of Lambda ARNs to local function names.
    state_machine_config_class:
        The StateMachineConfig dataclass.
    workflow_type_enum:
        The WorkflowType enum class.
    """
    definition_string = resource_properties.get("DefinitionString", "{}")
    substitutions = resource_properties.get("DefinitionSubstitutions", {})
    workflow_type_str = resource_properties.get("StateMachineType", "STANDARD")
    workflow_type = _WorkflowTypeParser.parse(workflow_type_str, workflow_type_enum)

    definition = _apply_assembly_substitutions(definition_string, substitutions)
    if resource_mapping:
        definition = _remap_lambda_arns(definition, resource_mapping)

    return state_machine_config_class(
        name=logical_id,
        definition=definition,
        workflow_type=workflow_type,
        role_arn=resource_properties.get("RoleArn", ""),
        definition_substitutions={},
    )


def parse_cloud_assembly_state_machine(
    logical_id: str,
    resource_properties: dict[str, Any],
    resource_mapping: dict[str, str] | None = None,
) -> StateMachineConfig:
    """Parse an AWS::StepFunctions::StateMachine from cloud assembly properties."""
    from lws.providers.stepfunctions.provider import (  # pylint: disable=import-outside-toplevel
        StateMachineConfig,
        WorkflowType,
    )

    return _parse_cloud_assembly_config(
        logical_id, resource_properties, resource_mapping, StateMachineConfig, WorkflowType
    )
