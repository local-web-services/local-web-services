"""Step Functions provider implementing IStateMachine.

Manages state machine definitions, executions, and lifecycle.
Supports both Standard (async) and Express (sync) workflow types.
"""

from __future__ import annotations

import json
import logging
import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any

from lws.interfaces.compute import ICompute, InvocationResult, LambdaContext
from lws.interfaces.state_machine import IStateMachine
from lws.providers.stepfunctions.asl_parser import (
    StateMachineDefinition,
    parse_definition,
)
from lws.providers.stepfunctions.engine import (
    ComputeInvoker,
    ExecutionEngine,
    ExecutionHistory,
    ExecutionStatus,
)

logger = logging.getLogger(__name__)


# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------


class WorkflowType(Enum):
    """State machine workflow type."""

    STANDARD = "STANDARD"
    EXPRESS = "EXPRESS"


@dataclass
class StateMachineConfig:
    """Configuration for a single state machine."""

    name: str
    definition: str | dict
    workflow_type: WorkflowType = WorkflowType.STANDARD
    role_arn: str = ""
    definition_substitutions: dict[str, str] = field(default_factory=dict)


# ---------------------------------------------------------------------------
# Compute bridge - adapts ICompute to ComputeInvoker protocol
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
# Provider
# ---------------------------------------------------------------------------


class StepFunctionsProvider(IStateMachine):
    """In-memory Step Functions provider.

    Manages state machine definitions and executions, supporting
    both Standard and Express workflow types.
    """

    def __init__(
        self,
        state_machines: list[StateMachineConfig] | None = None,
        max_wait_seconds: float = 5.0,
    ) -> None:
        self._configs: dict[str, StateMachineConfig] = {}
        self._definitions: dict[str, StateMachineDefinition] = {}
        self._workflow_types: dict[str, WorkflowType] = {}
        self._executions: dict[str, ExecutionHistory] = {}
        self._compute_providers: dict[str, ICompute] = {}
        self._max_wait_seconds = max_wait_seconds
        self._running = False

        for sm in state_machines or []:
            self._configs[sm.name] = sm

    # ------------------------------------------------------------------
    # Provider lifecycle
    # ------------------------------------------------------------------

    @property
    def name(self) -> str:
        return "stepfunctions"

    async def start(self) -> None:
        """Parse all state machine definitions and mark provider as running."""
        for sm_name, config in self._configs.items():
            definition_data = _resolve_definition(config)
            self._definitions[sm_name] = parse_definition(definition_data)
            self._workflow_types[sm_name] = config.workflow_type
        self._running = True
        logger.info("StepFunctions provider started with %d state machines", len(self._definitions))

    async def stop(self) -> None:
        """Stop the provider and clear state."""
        self._definitions.clear()
        self._executions.clear()
        self._workflow_types.clear()
        self._running = False

    async def health_check(self) -> bool:
        """Return True if the provider is running."""
        return self._running

    # ------------------------------------------------------------------
    # Cross-provider wiring
    # ------------------------------------------------------------------

    def set_compute_providers(self, providers: dict[str, ICompute]) -> None:
        """Register compute providers for Lambda Task invocation."""
        self._compute_providers = providers

    # ------------------------------------------------------------------
    # IStateMachine implementation
    # ------------------------------------------------------------------

    async def start_execution(
        self,
        state_machine_name: str,
        input_data: dict | None = None,
        execution_name: str | None = None,
    ) -> dict:
        """Start a state machine execution.

        For STANDARD workflows, returns immediately with an execution ARN.
        For EXPRESS workflows, blocks until execution completes.
        """
        definition = self._get_definition(state_machine_name)
        workflow_type = self._workflow_types.get(state_machine_name, WorkflowType.STANDARD)

        if execution_name is None:
            execution_name = str(uuid.uuid4())

        execution_arn = _build_execution_arn(state_machine_name, execution_name)

        if workflow_type == WorkflowType.EXPRESS:
            return await self._run_sync_execution(
                definition, state_machine_name, execution_arn, input_data
            )
        return await self._start_async_execution(
            definition, state_machine_name, execution_arn, input_data
        )

    # ------------------------------------------------------------------
    # Execution accessors
    # ------------------------------------------------------------------

    def get_execution(self, execution_arn: str) -> ExecutionHistory | None:
        """Get the execution history for a given ARN."""
        return self._executions.get(execution_arn)

    def list_executions(self, state_machine_name: str | None = None) -> list[ExecutionHistory]:
        """List executions, optionally filtered by state machine name."""
        if state_machine_name is None:
            return list(self._executions.values())
        return [h for h in self._executions.values() if h.state_machine_name == state_machine_name]

    def list_state_machines(self) -> list[str]:
        """Return sorted list of state machine names."""
        return sorted(self._definitions.keys())

    def get_definition(self, name: str) -> StateMachineDefinition | None:
        """Return the parsed definition for a state machine."""
        return self._definitions.get(name)

    # ------------------------------------------------------------------
    # Management operations
    # ------------------------------------------------------------------

    def create_state_machine(
        self,
        name: str,
        definition: str | dict,
        role_arn: str = "",
        workflow_type: str = "STANDARD",
    ) -> str:
        """Create a state machine dynamically. Returns the state machine ARN.

        Idempotent: if a state machine with the same name exists, its
        definition is updated.
        """
        wf_type = WorkflowType.EXPRESS if workflow_type == "EXPRESS" else WorkflowType.STANDARD
        config = StateMachineConfig(
            name=name,
            definition=definition,
            workflow_type=wf_type,
            role_arn=role_arn,
        )
        self._configs[name] = config
        definition_data = _resolve_definition(config)
        self._definitions[name] = parse_definition(definition_data)
        self._workflow_types[name] = wf_type
        return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"

    def delete_state_machine(self, name: str) -> None:
        """Delete a state machine by name. Raises KeyError if not found."""
        if name not in self._definitions:
            raise KeyError(f"State machine not found: {name}")
        del self._definitions[name]
        self._configs.pop(name, None)
        self._workflow_types.pop(name, None)

    def describe_state_machine(self, name: str) -> dict:
        """Describe a state machine. Raises KeyError if not found."""
        if name not in self._definitions:
            raise KeyError(f"State machine not found: {name}")
        config = self._configs.get(name)
        wf_type = self._workflow_types.get(name, WorkflowType.STANDARD)
        return {
            "name": name,
            "stateMachineArn": f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}",
            "type": wf_type.value,
            "roleArn": config.role_arn if config else "",
            "status": "ACTIVE",
            "creationDate": time.time(),
        }

    # ------------------------------------------------------------------
    # Internal execution methods
    # ------------------------------------------------------------------

    async def _run_sync_execution(
        self,
        definition: StateMachineDefinition,
        state_machine_name: str,
        execution_arn: str,
        input_data: Any,
    ) -> dict:
        """Run an EXPRESS (synchronous) execution and return the result."""
        engine = self._create_engine(definition)
        history = await engine.execute(input_data, execution_arn, state_machine_name)
        self._executions[execution_arn] = history
        return _build_sync_response(history)

    async def _start_async_execution(
        self,
        definition: StateMachineDefinition,
        state_machine_name: str,
        execution_arn: str,
        input_data: Any,
    ) -> dict:
        """Start a STANDARD (asynchronous) execution in the background."""
        engine = self._create_engine(definition)
        # Create a placeholder history entry
        history = ExecutionHistory(
            execution_arn=execution_arn,
            state_machine_name=state_machine_name,
            start_time=time.time(),
            input_data=input_data,
        )
        self._executions[execution_arn] = history

        # Run in background - actual history will be updated
        import asyncio

        asyncio.create_task(
            self._run_background_execution(engine, execution_arn, state_machine_name, input_data)
        )
        return _build_async_response(execution_arn)

    async def _run_background_execution(
        self,
        engine: ExecutionEngine,
        execution_arn: str,
        state_machine_name: str,
        input_data: Any,
    ) -> None:
        """Run an execution in the background and store the result."""
        try:
            history = await engine.execute(input_data, execution_arn, state_machine_name)
            self._executions[execution_arn] = history
        except Exception as exc:
            logger.exception("Background execution failed: %s", execution_arn)
            existing = self._executions.get(execution_arn)
            if existing:
                existing.status = ExecutionStatus.FAILED
                existing.error = "States.Runtime"
                existing.cause = str(exc)
                existing.end_time = time.time()

    def _create_engine(self, definition: StateMachineDefinition) -> ExecutionEngine:
        """Create an execution engine with the current compute bridge."""
        compute: ComputeInvoker | None = None
        if self._compute_providers:
            compute = LambdaComputeBridge(self._compute_providers)
        return ExecutionEngine(
            definition=definition,
            compute=compute,
            max_wait_seconds=self._max_wait_seconds,
        )

    def _get_definition(self, name: str) -> StateMachineDefinition:
        """Retrieve a state machine definition by name."""
        definition = self._definitions.get(name)
        if definition is None:
            raise KeyError(f"State machine not found: {name}")
        return definition


# ---------------------------------------------------------------------------
# Helper functions
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


def _process_invocation_result(result: InvocationResult, resource_arn: str) -> Any:
    """Process an InvocationResult, raising on error."""
    if result.error:
        from lws.providers.stepfunctions.engine import StatesTaskFailed

        raise StatesTaskFailed(
            error="States.TaskFailed",
            cause=result.error,
        )
    return result.payload


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


# ---------------------------------------------------------------------------
# Cloud Assembly parsing (P2-17)
# ---------------------------------------------------------------------------


def parse_cloud_assembly_state_machine(
    logical_id: str,
    resource_properties: dict[str, Any],
    resource_mapping: dict[str, str] | None = None,
) -> StateMachineConfig:
    """Parse an AWS::StepFunctions::StateMachine from cloud assembly properties.

    Parameters
    ----------
    logical_id:
        The CloudFormation logical ID.
    resource_properties:
        The Properties dict from the CloudFormation resource.
    resource_mapping:
        Optional mapping of Lambda ARNs to local function names.
    """
    definition_string = resource_properties.get("DefinitionString", "{}")
    substitutions = resource_properties.get("DefinitionSubstitutions", {})
    workflow_type_str = resource_properties.get("StateMachineType", "STANDARD")
    workflow_type = _parse_workflow_type(workflow_type_str)

    definition = _apply_assembly_substitutions(definition_string, substitutions)
    if resource_mapping:
        definition = _remap_lambda_arns(definition, resource_mapping)

    return StateMachineConfig(
        name=logical_id,
        definition=definition,
        workflow_type=workflow_type,
        role_arn=resource_properties.get("RoleArn", ""),
        definition_substitutions={},
    )


def _parse_workflow_type(type_str: str) -> WorkflowType:
    """Parse a workflow type string into the enum."""
    try:
        return WorkflowType(type_str.upper())
    except ValueError:
        return WorkflowType.STANDARD


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
