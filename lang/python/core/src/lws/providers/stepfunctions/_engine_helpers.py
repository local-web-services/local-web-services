"""Helper functions for the Step Functions execution engine."""

from __future__ import annotations

import asyncio
import time
from datetime import UTC, datetime
from typing import Any

from lws.providers.stepfunctions._engine_state import (
    ExecutionHistory,
    ExecutionStatus,
    StatesError,
)
from lws.providers.stepfunctions.asl_parser import (
    CatchConfig,
    MapState,
    ParallelState,
    PassState,
    RetryConfig,
    StateMachineDefinition,
    TaskState,
    WaitState,
)
from lws.providers.stepfunctions.jsonata_evaluator import (
    evaluate_assign,
    evaluate_output,
    expand_arguments,
    resolve_credentials,
)
from lws.providers.stepfunctions.path_utils import (
    apply_context_parameters,
    apply_output_path,
    apply_parameters,
    apply_result_path,
    resolve_path,
)


def _is_jsonata_mode(state: Any, definition: StateMachineDefinition) -> bool:
    """Return True if the state should be executed in JSONata mode."""
    state_ql = getattr(state, "query_language", None)
    if state_ql is not None:
        return state_ql == "JSONata"
    return definition.query_language == "JSONata"


def _prepare_jsonata_pass_input(
    state: PassState, input_data: Any, variables: dict[str, Any] | None = None
) -> Any:
    """Prepare effective input for a JSONata Pass state using Arguments."""
    if state.arguments is not None:
        return expand_arguments(state.arguments, input_data, variables=variables)
    return input_data


def _apply_jsonata_pass_output(
    state: PassState, effective_input: Any, variables: dict[str, Any] | None = None
) -> Any:
    """Apply JSONata Output expression to produce Pass state output."""
    if state.output is not None:
        return evaluate_output(state.output, effective_input, variables=variables)
    return effective_input


def _prepare_jsonata_task_input(
    state: TaskState, input_data: Any, variables: dict[str, Any] | None = None
) -> Any:
    """Prepare effective input for a JSONata Task state using Arguments."""
    if state.arguments is not None:
        return expand_arguments(state.arguments, input_data, variables=variables)
    return input_data


def _apply_jsonata_task_output(
    state: TaskState,
    original_input: Any,
    task_result: Any,
    variables: dict[str, Any] | None = None,
) -> tuple[Any, str | None]:
    """Apply JSONata Output expression to task result."""
    if state.output is not None:
        output = evaluate_output(
            state.output, original_input, result=task_result, variables=variables
        )
    else:
        output = task_result
    return output, _next_or_none(state.next_state, state.end)


def _apply_assign(state: Any, output: Any, variables: dict[str, Any], result: Any = None) -> None:
    """Evaluate Assign on a state and merge results into the variables dict in place."""
    assign = getattr(state, "assign", None)
    if assign is not None:
        new_vars = evaluate_assign(assign, output, variables=variables, result=result)
        variables.update(new_vars)


def _resolve_task_credentials(
    state: TaskState, input_data: Any, variables: dict[str, Any] | None = None
) -> dict[str, Any] | None:
    """Resolve Credentials dict for a Task state, evaluating any {%...%} expressions."""
    if state.credentials is None:
        return None
    return resolve_credentials(state.credentials, input_data, variables=variables)


def _next_or_none(next_state: str | None, end: bool) -> str | None:
    """Return next state name or None if this is a terminal state."""
    if end:
        return None
    return next_state


def _prepare_task_input(state: TaskState, input_data: Any) -> Any:
    """Prepare the effective input for a task invocation."""
    from lws.providers.stepfunctions.path_utils import (  # pylint: disable=import-outside-toplevel
        apply_input_path,
    )

    effective_input = apply_input_path(input_data, state.input_path)
    if state.parameters:
        effective_input = apply_parameters(state.parameters, effective_input)
    return effective_input


def _apply_task_output(
    state: TaskState, original_input: Any, result: Any
) -> tuple[Any, str | None]:
    """Apply ResultSelector, ResultPath, and OutputPath to task result."""
    if state.result_selector:
        result = apply_parameters(state.result_selector, result)
    output = apply_result_path(original_input, result, state.result_path)
    output = apply_output_path(output, state.output_path)
    return output, _next_or_none(state.next_state, state.end)


def _handle_task_catch(
    state: TaskState, input_data: Any, exc: StatesError
) -> tuple[Any, str | None]:
    """Handle a task error using Catch configuration."""
    if state.catch:
        for catch_config in state.catch:
            if _error_matches(exc.error, catch_config.error_equals):
                return _apply_catch(input_data, catch_config, exc)
    raise exc


def _handle_parallel_catch(
    state: ParallelState, input_data: Any, exc: StatesError
) -> tuple[Any, str | None]:
    """Handle a parallel branch error using Catch configuration."""
    if state.catch:
        for catch_config in state.catch:
            if _error_matches(exc.error, catch_config.error_equals):
                return _apply_catch(input_data, catch_config, exc)
    raise exc


def _handle_map_catch(state: MapState, input_data: Any, exc: StatesError) -> tuple[Any, str | None]:
    """Handle a map iteration error using Catch configuration."""
    if state.catch:
        for catch_config in state.catch:
            if _error_matches(exc.error, catch_config.error_equals):
                return _apply_catch(input_data, catch_config, exc)
    raise exc


def _apply_catch(
    input_data: Any, catch_config: CatchConfig, exc: StatesError
) -> tuple[Any, str | None]:
    """Apply catch configuration to produce output and next state."""
    error_info = {"Error": exc.error, "Cause": exc.cause or str(exc)}
    output = apply_result_path(input_data, error_info, catch_config.result_path)
    return output, catch_config.next_state


def _apply_parallel_output(state: ParallelState, original_input: Any, results: list[Any]) -> Any:
    """Apply ResultSelector, ResultPath, and OutputPath to parallel results."""
    result = results
    if state.result_selector:
        result = apply_parameters(state.result_selector, result)
    output = apply_result_path(original_input, result, state.result_path)
    return apply_output_path(output, state.output_path)


def _error_matches(error_name: str, error_equals: list[str]) -> bool:
    """Check if an error name matches any of the error patterns."""
    if "States.ALL" in error_equals:
        return True
    return error_name in error_equals


def _calculate_retry_delay(retry_config: RetryConfig, attempt: int) -> float:
    """Calculate the delay before the next retry attempt."""
    return retry_config.interval_seconds * (retry_config.backoff_rate**attempt)


def _resolve_wait_seconds(state: WaitState, input_data: Any) -> float:
    """Resolve the number of seconds to wait based on state configuration."""
    if state.seconds is not None:
        return float(state.seconds)
    if state.seconds_path is not None:
        val = resolve_path(input_data, state.seconds_path)
        return float(val)
    if state.timestamp is not None:
        return _seconds_until_timestamp(state.timestamp)
    if state.timestamp_path is not None:
        ts = resolve_path(input_data, state.timestamp_path)
        return _seconds_until_timestamp(ts)
    return 0.0


def _seconds_until_timestamp(timestamp: str) -> float:
    """Calculate seconds until an ISO 8601 timestamp."""
    target = datetime.fromisoformat(timestamp.replace("Z", "+00:00"))
    now = datetime.now(UTC)
    diff = (target - now).total_seconds()
    return max(0.0, diff)


def _resolve_map_items(state: MapState, effective_input: Any) -> list:
    """Resolve the items to iterate over in a Map state."""
    if state.items_path and state.items_path != "$":
        items = resolve_path(effective_input, state.items_path)
    else:
        items = effective_input
    if not isinstance(items, list):
        raise StatesError("States.Runtime", "Map state items must be a list")
    return items


def _build_map_item_input(
    state: MapState,
    effective_input: Any,
    item: Any,
    index: int,
) -> Any:
    """Build the input for a single Map iteration."""
    if state.parameters:
        context = {"Map": {"Item": {"Value": item, "Index": index}}}
        return apply_context_parameters(state.parameters, effective_input, context)
    return item


def _create_map_semaphore(max_concurrency: int) -> asyncio.Semaphore | None:
    """Create a semaphore for Map concurrency limiting, or None for unlimited."""
    if max_concurrency > 0:
        return asyncio.Semaphore(max_concurrency)
    return None


def _mark_succeeded(history: ExecutionHistory, result: Any) -> None:
    """Mark an execution as succeeded."""
    history.status = ExecutionStatus.SUCCEEDED
    history.output_data = result
    history.end_time = time.time()


def _mark_failed(history: ExecutionHistory, error: str, cause: str | None) -> None:
    """Mark an execution as failed."""
    history.status = ExecutionStatus.FAILED
    history.error = error
    history.cause = cause
    history.end_time = time.time()
