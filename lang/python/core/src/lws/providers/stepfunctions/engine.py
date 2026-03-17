"""Step Functions execution engine.

Implements the recursive state walker that processes state machine definitions.
Handles all state types, error handling (Retry/Catch), and execution tracking.
"""

from __future__ import annotations

import asyncio
import logging
import time
import uuid
from typing import Any, Protocol

from lws.providers.stepfunctions._engine_helpers import (
    _apply_parallel_output,
    _apply_task_output,
    _build_map_item_input,
    _calculate_retry_delay,
    _create_map_semaphore,
    _error_matches,
    _handle_map_catch,
    _handle_parallel_catch,
    _handle_task_catch,
    _mark_failed,
    _mark_succeeded,
    _next_or_none,
    _prepare_task_input,
    _resolve_map_items,
    _resolve_wait_seconds,
)
from lws.providers.stepfunctions._engine_state import (
    ExecutionHistory,
    ExecutionStatus,
    StatesError,
    StatesTaskFailed,  # noqa: F401
    StatesTimeout,
    StateTransition,
)
from lws.providers.stepfunctions.asl_parser import (
    ChoiceState,
    FailState,
    MapState,
    ParallelState,
    PassState,
    RetryConfig,
    StateMachineDefinition,
    SucceedState,
    TaskState,
    WaitState,
)
from lws.providers.stepfunctions.choice_evaluator import evaluate_choice_rules
from lws.providers.stepfunctions.path_utils import (
    apply_input_path,
    apply_output_path,
    apply_parameters,
    apply_result_path,
)

logger = logging.getLogger(__name__)


# ---------------------------------------------------------------------------
# Compute interface protocol
# ---------------------------------------------------------------------------


class ComputeInvoker(Protocol):
    """Protocol for invoking compute functions."""

    async def invoke_function(self, resource_arn: str, payload: Any) -> Any:
        """Invoke a compute function by resource ARN with the given payload."""


# ---------------------------------------------------------------------------
# Execution engine
# ---------------------------------------------------------------------------


class ExecutionEngine:
    """Executes a state machine definition step by step.

    Parameters
    ----------
    definition:
        The parsed state machine definition.
    compute:
        Optional compute invoker for Task states.
    max_wait_seconds:
        Maximum wait time compression for local development.
    """

    def __init__(
        self,
        definition: StateMachineDefinition,
        compute: ComputeInvoker | None = None,
        max_wait_seconds: float = 5.0,
    ) -> None:
        self._definition = definition
        self._compute = compute
        self._max_wait_seconds = max_wait_seconds

    async def execute(
        self,
        input_data: Any = None,
        execution_arn: str | None = None,
        state_machine_name: str = "local-state-machine",
    ) -> ExecutionHistory:
        """Execute the state machine with the given input."""
        if execution_arn is None:
            uid = uuid.uuid4()
            execution_arn = (
                f"arn:aws:states:us-east-1:000000000000:execution:{state_machine_name}:{uid}"
            )

        history = ExecutionHistory(
            execution_arn=execution_arn,
            state_machine_name=state_machine_name,
            start_time=time.time(),
            input_data=input_data,
        )

        try:
            result = await self._run_state_machine(input_data, history)
            _mark_succeeded(history, result)
        except StatesError as exc:
            _mark_failed(history, exc.error, exc.cause)
        except Exception as exc:
            _mark_failed(history, "States.Runtime", str(exc))

        return history

    async def _run_state_machine(
        self,
        input_data: Any,
        history: ExecutionHistory,
    ) -> Any:
        """Walk through states from StartAt until terminal state."""
        current_state_name = self._definition.start_at
        current_data = input_data

        while current_state_name is not None:
            state = self._definition.states.get(current_state_name)
            if state is None:
                raise StatesError("States.Runtime", f"State not found: {current_state_name}")

            transition = StateTransition(
                state_name=current_state_name,
                state_type=type(state).__name__,
                timestamp=time.time(),
                input_data=current_data,
            )
            history.transitions.append(transition)

            current_data, current_state_name = await self._execute_state(
                state, current_data, transition
            )
            transition.output_data = current_data

        return current_data

    async def _execute_state(
        self,
        state: Any,
        input_data: Any,
        _transition: StateTransition,
    ) -> tuple[Any, str | None]:
        """Execute a single state and return (output, next_state_name)."""
        handlers = {
            PassState: self._execute_pass,
            TaskState: self._execute_task,
            ChoiceState: self._execute_choice,
            WaitState: self._execute_wait,
            SucceedState: self._execute_succeed,
            FailState: self._execute_fail,
            ParallelState: self._execute_parallel,
            MapState: self._execute_map,
        }
        handler = handlers.get(type(state))
        if handler is None:
            raise StatesError("States.Runtime", f"Unsupported state type: {type(state).__name__}")
        return await handler(state, input_data)

    # -------------------------------------------------------------------
    # Pass state
    # -------------------------------------------------------------------

    async def _execute_pass(self, state: PassState, input_data: Any) -> tuple[Any, str | None]:
        """Execute a Pass state."""
        effective_input = apply_input_path(input_data, state.input_path)
        if state.parameters:
            effective_input = apply_parameters(state.parameters, effective_input)
        result = state.result if state.result is not None else effective_input
        output = apply_result_path(effective_input, result, state.result_path)
        output = apply_output_path(output, state.output_path)
        return output, _next_or_none(state.next_state, state.end)

    # -------------------------------------------------------------------
    # Task state (P2-09)
    # -------------------------------------------------------------------

    async def _execute_task(self, state: TaskState, input_data: Any) -> tuple[Any, str | None]:
        """Execute a Task state with retry/catch support."""
        effective_input = _prepare_task_input(state, input_data)
        try:
            result = await self._invoke_with_retry(state, effective_input)
            return _apply_task_output(state, input_data, result)
        except StatesError as exc:
            return _handle_task_catch(state, input_data, exc)

    async def _invoke_with_retry(self, state: TaskState, effective_input: Any) -> Any:
        """Invoke a task with retry logic."""
        if not state.retry:
            return await self._invoke_task(state, effective_input)

        last_error: StatesError | None = None
        for retry_config in state.retry:
            result_or_error = await self._attempt_retry_block(state, effective_input, retry_config)
            if not isinstance(result_or_error, StatesError):
                return result_or_error
            last_error = result_or_error

        if last_error is not None:
            raise last_error
        return await self._invoke_task(state, effective_input)

    async def _attempt_retry_block(
        self,
        state: TaskState,
        effective_input: Any,
        retry_config: RetryConfig,
    ) -> Any:
        """Attempt a single retry block. Returns result on success or StatesError on failure."""
        last_error: StatesError | None = None
        for attempt in range(retry_config.max_attempts + 1):
            try:
                return await self._invoke_task(state, effective_input)
            except StatesError as exc:
                if not _error_matches(exc.error, retry_config.error_equals):
                    raise
                last_error = exc
                if attempt < retry_config.max_attempts:
                    delay = _calculate_retry_delay(retry_config, attempt)
                    await asyncio.sleep(delay)

        if last_error is not None:
            return last_error
        raise StatesError("States.Runtime", "Unexpected retry state")

    async def _invoke_task(self, state: TaskState, payload: Any) -> Any:
        """Invoke the task resource with optional timeout."""
        if self._compute is None:
            raise StatesError("States.Runtime", "No compute invoker configured")

        if state.timeout_seconds:
            return await self._invoke_with_timeout(state, payload)

        return await self._compute.invoke_function(state.resource, payload)

    async def _invoke_with_timeout(self, state: TaskState, payload: Any) -> Any:
        """Invoke a task with a timeout enforced."""
        try:
            return await asyncio.wait_for(
                self._compute.invoke_function(state.resource, payload),
                timeout=state.timeout_seconds,
            )
        except TimeoutError as exc:
            raise StatesTimeout(
                "States.Timeout",
                f"Task timed out after {state.timeout_seconds}s",
            ) from exc

    # -------------------------------------------------------------------
    # Choice state (P2-10)
    # -------------------------------------------------------------------

    async def _execute_choice(self, state: ChoiceState, input_data: Any) -> tuple[Any, str | None]:
        """Execute a Choice state by evaluating rules."""
        effective_input = apply_input_path(input_data, state.input_path)
        next_state = evaluate_choice_rules(state.choices, effective_input)
        if next_state is None:
            next_state = state.default
        if next_state is None:
            raise StatesError("States.NoChoiceMatched", "No choice rule matched and no Default")
        output = apply_output_path(effective_input, state.output_path)
        return output, next_state

    # -------------------------------------------------------------------
    # Wait state (P2-11)
    # -------------------------------------------------------------------

    async def _execute_wait(self, state: WaitState, input_data: Any) -> tuple[Any, str | None]:
        """Execute a Wait state."""
        effective_input = apply_input_path(input_data, state.input_path)
        wait_seconds = _resolve_wait_seconds(state, effective_input)
        clamped = min(wait_seconds, self._max_wait_seconds)
        if clamped > 0:
            await asyncio.sleep(clamped)
        output = apply_output_path(effective_input, state.output_path)
        return output, _next_or_none(state.next_state, state.end)

    # -------------------------------------------------------------------
    # Succeed / Fail states
    # -------------------------------------------------------------------

    async def _execute_succeed(
        self, state: SucceedState, input_data: Any
    ) -> tuple[Any, str | None]:
        """Execute a Succeed state (terminal)."""
        effective_input = apply_input_path(input_data, state.input_path)
        output = apply_output_path(effective_input, state.output_path)
        return output, None

    async def _execute_fail(self, state: FailState, input_data: Any) -> tuple[Any, str | None]:
        """Execute a Fail state (terminal with error)."""
        raise StatesError(
            error=state.error or "States.Fail",
            cause=state.cause,
        )

    # -------------------------------------------------------------------
    # Parallel state (P2-13)
    # -------------------------------------------------------------------

    async def _execute_parallel(
        self, state: ParallelState, input_data: Any
    ) -> tuple[Any, str | None]:
        """Execute a Parallel state with concurrent branches."""
        effective_input = apply_input_path(input_data, state.input_path)
        try:
            results = await self._run_parallel_branches(state, effective_input)
        except StatesError as exc:
            return _handle_parallel_catch(state, input_data, exc)

        output = _apply_parallel_output(state, input_data, results)
        return output, _next_or_none(state.next_state, state.end)

    async def _run_parallel_branches(self, state: ParallelState, effective_input: Any) -> list[Any]:
        """Run all branches concurrently and collect results."""
        tasks = [self._run_branch(branch, effective_input) for branch in state.branches]
        try:
            results = await asyncio.gather(*tasks, return_exceptions=False)
        except Exception:
            # Cancel remaining tasks on branch failure
            for task in tasks:
                if isinstance(task, asyncio.Task) and not task.done():
                    task.cancel()
            raise
        return list(results)

    async def _run_branch(self, branch: StateMachineDefinition, input_data: Any) -> Any:
        """Run a single branch as a sub-state-machine."""
        sub_engine = ExecutionEngine(
            definition=branch,
            compute=self._compute,
            max_wait_seconds=self._max_wait_seconds,
        )
        history = await sub_engine.execute(input_data)
        if history.status == ExecutionStatus.FAILED:
            raise StatesError(
                error=history.error or "States.BranchFailed",
                cause=history.cause,
            )
        return history.output_data

    # -------------------------------------------------------------------
    # Map state (P2-14)
    # -------------------------------------------------------------------

    async def _execute_map(self, state: MapState, input_data: Any) -> tuple[Any, str | None]:
        """Execute a Map state, iterating over items."""
        effective_input = apply_input_path(input_data, state.input_path)
        items = _resolve_map_items(state, effective_input)

        try:
            results = await self._run_map_iterations(state, effective_input, items)
        except StatesError as exc:
            return _handle_map_catch(state, input_data, exc)

        output = apply_result_path(effective_input, results, state.result_path)
        if state.result_selector:
            output = apply_parameters(state.result_selector, output)
        output = apply_output_path(output, state.output_path)
        return output, _next_or_none(state.next_state, state.end)

    async def _run_map_iterations(
        self,
        state: MapState,
        effective_input: Any,
        items: list,
    ) -> list[Any]:
        """Run Map iterations with optional concurrency limiting."""
        if state.iterator is None:
            raise StatesError("States.Runtime", "Map state has no Iterator")

        semaphore = _create_map_semaphore(state.max_concurrency)

        tasks = [
            self._run_map_item(state, effective_input, item, index, semaphore)
            for index, item in enumerate(items)
        ]
        return list(await asyncio.gather(*tasks))

    async def _run_map_item(
        self,
        state: MapState,
        effective_input: Any,
        item: Any,
        index: int,
        semaphore: asyncio.Semaphore | None,
    ) -> Any:
        """Run a single Map iteration."""
        item_input = _build_map_item_input(state, effective_input, item, index)

        if semaphore:
            async with semaphore:
                return await self._run_branch(state.iterator, item_input)
        return await self._run_branch(state.iterator, item_input)


