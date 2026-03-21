"""Step Functions provider implementing IStateMachine.

Manages state machine definitions, executions, and lifecycle.
Supports both Standard (async) and Express (sync) workflow types.
"""

from __future__ import annotations

import logging
import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any

from lws.interfaces.compute import ICompute
from lws.interfaces.state_machine import IStateMachine
from lws.providers.stepfunctions._provider_helpers import (
    LambdaComputeBridge,
    _build_async_response,
    _build_execution_arn,
    _build_execution_history_events,
    _build_state_machine_description,
    _build_sync_response,
    _parse_cloud_assembly_config,
    _resolve_definition,
)
from lws.providers.stepfunctions._service_task_bridge import (
    ServiceTaskBridge,
    _CompositeComputeInvoker,
)
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
        self._service_providers: dict[str, Any] = {}
        self._tags: dict[str, dict[str, str]] = {}
        self._max_wait_seconds = max_wait_seconds
        self._running = False
        # Track names of pre-configured (static) state machines so reset()
        # knows which dynamically-created ones to remove.
        self._static_names: set[str] = set()

        for sm in state_machines or []:
            self._configs[sm.name] = sm
            self._static_names.add(sm.name)

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

    async def reset(self) -> None:
        """Clear all executions and dynamically created state machines.

        Pre-configured state machines (from __init__) are preserved.
        """
        self._executions.clear()
        self._tags.clear()
        # Remove any state machines that were created dynamically (not pre-configured)
        dynamic_names = [n for n in list(self._definitions.keys()) if n not in self._static_names]
        for name in dynamic_names:
            del self._definitions[name]
            self._configs.pop(name, None)
            self._workflow_types.pop(name, None)
        # Re-parse all pre-configured state machines to restore clean state
        for sm_name in self._static_names:
            config = self._configs.get(sm_name)
            if config is not None:
                definition_data = _resolve_definition(config)
                self._definitions[sm_name] = parse_definition(definition_data)
                self._workflow_types[sm_name] = config.workflow_type

    async def health_check(self) -> bool:
        """Return True if the provider is running."""
        return self._running

    # ------------------------------------------------------------------
    # Cross-provider wiring
    # ------------------------------------------------------------------

    def set_compute_providers(self, providers: dict[str, ICompute]) -> None:
        """Register compute providers for Lambda Task invocation."""
        self._compute_providers = providers

    def set_service_providers(self, providers: dict[str, Any]) -> None:
        """Register service providers for service integration Task invocation."""
        self._service_providers = providers

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

    def get_workflow_type(self, name: str) -> str | None:
        """Return the workflow type string for a state machine, or None if not found."""
        wf_type = self._workflow_types.get(name)
        if wf_type is None:
            return None
        return wf_type.value

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
        arn = f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
        if name in self._definitions:
            raise ValueError(f"State machine already exists: {name}")
        self._configs[name] = config
        definition_data = _resolve_definition(config)
        self._definitions[name] = parse_definition(definition_data)
        self._workflow_types[name] = wf_type
        return arn

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
        return _build_state_machine_description(
            name, self._configs, self._workflow_types, WorkflowType.STANDARD
        )

    def stop_execution(
        self,
        execution_arn: str,
        error: str | None = None,
        cause: str | None = None,
    ) -> None:
        """Stop a running execution by setting its status to ABORTED.

        Raises KeyError if the execution does not exist.
        """
        history = self._executions.get(execution_arn)
        if history is None:
            raise KeyError(f"Execution not found: {execution_arn}")
        history.status = ExecutionStatus.ABORTED
        history.end_time = time.time()
        if error is not None:
            history.error = error
        if cause is not None:
            history.cause = cause

    def update_state_machine(
        self,
        name: str,
        definition: str | dict | None = None,
        role_arn: str | None = None,
    ) -> float:
        """Update a state machine's configuration.

        Returns the update timestamp. Raises KeyError if not found.
        """
        if name not in self._definitions:
            raise KeyError(f"State machine not found: {name}")

        config = self._configs.get(name)
        if config is None:
            raise KeyError(f"State machine config not found: {name}")

        if definition is not None:
            config.definition = definition
            definition_data = _resolve_definition(config)
            self._definitions[name] = parse_definition(definition_data)

        if role_arn is not None:
            config.role_arn = role_arn

        return time.time()

    def tag_resource(self, resource_arn: str, tags: list[dict[str, str]]) -> None:
        """Add tags to a resource identified by ARN."""
        if resource_arn not in self._tags:
            self._tags[resource_arn] = {}
        for tag in tags:
            self._tags[resource_arn][tag["key"]] = tag["value"]

    def untag_resource(self, resource_arn: str, tag_keys: list[str]) -> None:
        """Remove tags from a resource identified by ARN."""
        if resource_arn in self._tags:
            for key in tag_keys:
                self._tags[resource_arn].pop(key, None)

    def list_tags_for_resource(self, resource_arn: str) -> list[dict[str, str]]:
        """Return tags for a resource as a list of {key, value} dicts."""
        tags = self._tags.get(resource_arn, {})
        return [{"key": k, "value": v} for k, v in tags.items()]

    def get_execution_history(
        self,
        execution_arn: str,
        max_results: int | None = None,
    ) -> list[dict]:
        """Return execution history events for a given execution ARN.

        Returns a list of event dicts. Raises KeyError if the execution
        does not exist.
        """
        history = self._executions.get(execution_arn)
        if history is None:
            raise KeyError(f"Execution not found: {execution_arn}")
        return _build_execution_history_events(history, max_results)

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
        import asyncio  # pylint: disable=import-outside-toplevel

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
        lambda_bridge = LambdaComputeBridge(self._compute_providers)
        if self._service_providers:
            service_bridge = ServiceTaskBridge(self._service_providers)
            compute = _CompositeComputeInvoker(service_bridge, lambda_bridge)
        elif self._compute_providers:
            compute = lambda_bridge
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
    return _parse_cloud_assembly_config(
        logical_id, resource_properties, resource_mapping, StateMachineConfig, WorkflowType
    )
