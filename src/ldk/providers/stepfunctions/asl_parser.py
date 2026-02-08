"""ASL (Amazon States Language) parser.

Parses JSON state machine definitions into internal dataclasses representing
the state graph. Supports all standard ASL state types: Task, Choice, Wait,
Parallel, Map, Pass, Succeed, and Fail.
"""

from __future__ import annotations

import json
from dataclasses import dataclass, field
from typing import Any

# ---------------------------------------------------------------------------
# Retry / Catch configuration
# ---------------------------------------------------------------------------


@dataclass
class RetryConfig:
    """Retry configuration for a state."""

    error_equals: list[str]
    interval_seconds: float = 1.0
    max_attempts: int = 3
    backoff_rate: float = 2.0


@dataclass
class CatchConfig:
    """Catch configuration for error handling."""

    error_equals: list[str]
    next_state: str
    result_path: str | None = "$.Error"


# ---------------------------------------------------------------------------
# Choice rule types
# ---------------------------------------------------------------------------


@dataclass
class ChoiceRule:
    """A single comparison rule within a Choice state."""

    next_state: str
    variable: str | None = None
    comparison_operator: str | None = None
    comparison_value: Any = None
    # For And/Or/Not combinators
    and_rules: list[ChoiceRule] | None = None
    or_rules: list[ChoiceRule] | None = None
    not_rule: ChoiceRule | None = None


# ---------------------------------------------------------------------------
# State dataclasses
# ---------------------------------------------------------------------------


@dataclass
class TaskState:
    """A Task state that invokes a resource (e.g., Lambda function)."""

    name: str
    resource: str
    next_state: str | None = None
    end: bool = False
    input_path: str | None = "$"
    output_path: str | None = "$"
    result_path: str | None = "$"
    parameters: dict[str, Any] | None = None
    result_selector: dict[str, Any] | None = None
    timeout_seconds: int | None = None
    retry: list[RetryConfig] = field(default_factory=list)
    catch: list[CatchConfig] = field(default_factory=list)
    comment: str | None = None


@dataclass
class ChoiceState:
    """A Choice state that branches based on conditions."""

    name: str
    choices: list[ChoiceRule] = field(default_factory=list)
    default: str | None = None
    input_path: str | None = "$"
    output_path: str | None = "$"
    comment: str | None = None


@dataclass
class WaitState:
    """A Wait state that pauses execution."""

    name: str
    next_state: str | None = None
    end: bool = False
    seconds: int | None = None
    timestamp: str | None = None
    seconds_path: str | None = None
    timestamp_path: str | None = None
    input_path: str | None = "$"
    output_path: str | None = "$"
    comment: str | None = None


@dataclass
class ParallelState:
    """A Parallel state that executes branches concurrently."""

    name: str
    branches: list[StateMachineDefinition] = field(default_factory=list)
    next_state: str | None = None
    end: bool = False
    input_path: str | None = "$"
    output_path: str | None = "$"
    result_path: str | None = "$"
    result_selector: dict[str, Any] | None = None
    retry: list[RetryConfig] = field(default_factory=list)
    catch: list[CatchConfig] = field(default_factory=list)
    comment: str | None = None


@dataclass
class MapState:
    """A Map state that iterates over items."""

    name: str
    iterator: StateMachineDefinition | None = None
    items_path: str | None = "$"
    max_concurrency: int = 0  # 0 means unlimited
    next_state: str | None = None
    end: bool = False
    input_path: str | None = "$"
    output_path: str | None = "$"
    result_path: str | None = "$"
    parameters: dict[str, Any] | None = None
    result_selector: dict[str, Any] | None = None
    retry: list[RetryConfig] = field(default_factory=list)
    catch: list[CatchConfig] = field(default_factory=list)
    comment: str | None = None


@dataclass
class PassState:
    """A Pass state that passes input to output with optional transformation."""

    name: str
    result: Any | None = None
    next_state: str | None = None
    end: bool = False
    input_path: str | None = "$"
    output_path: str | None = "$"
    result_path: str | None = "$"
    parameters: dict[str, Any] | None = None
    comment: str | None = None


@dataclass
class SucceedState:
    """A Succeed state that terminates execution successfully."""

    name: str
    input_path: str | None = "$"
    output_path: str | None = "$"
    comment: str | None = None


@dataclass
class FailState:
    """A Fail state that terminates execution with an error."""

    name: str
    error: str | None = None
    cause: str | None = None
    comment: str | None = None


# Union type for all state types
StateDefinition = (
    TaskState
    | ChoiceState
    | WaitState
    | ParallelState
    | MapState
    | PassState
    | SucceedState
    | FailState
)


@dataclass
class StateMachineDefinition:
    """Top-level state machine definition."""

    start_at: str
    states: dict[str, StateDefinition] = field(default_factory=dict)
    comment: str | None = None


# ---------------------------------------------------------------------------
# Parser functions - kept small to avoid complexity issues
# ---------------------------------------------------------------------------


def parse_definition(definition: str | dict) -> StateMachineDefinition:
    """Parse an ASL definition (JSON string or dict) into a StateMachineDefinition."""
    if isinstance(definition, str):
        definition = json.loads(definition)
    return _parse_state_machine_dict(definition)


def _parse_state_machine_dict(data: dict) -> StateMachineDefinition:
    """Parse a state machine dict into a StateMachineDefinition."""
    states: dict[str, StateDefinition] = {}
    for state_name, state_data in data.get("States", {}).items():
        states[state_name] = _parse_state(state_name, state_data)
    return StateMachineDefinition(
        start_at=data["StartAt"],
        states=states,
        comment=data.get("Comment"),
    )


def _parse_state(name: str, data: dict) -> StateDefinition:
    """Dispatch to the correct state parser based on Type."""
    state_type = data["Type"]
    parsers = {
        "Task": _parse_task_state,
        "Choice": _parse_choice_state,
        "Wait": _parse_wait_state,
        "Parallel": _parse_parallel_state,
        "Map": _parse_map_state,
        "Pass": _parse_pass_state,
        "Succeed": _parse_succeed_state,
        "Fail": _parse_fail_state,
    }
    parser = parsers.get(state_type)
    if parser is None:
        raise ValueError(f"Unknown state type: {state_type}")
    return parser(name, data)


def _parse_retry_list(data: dict) -> list[RetryConfig]:
    """Parse the Retry array from a state definition."""
    return [
        RetryConfig(
            error_equals=r["ErrorEquals"],
            interval_seconds=r.get("IntervalSeconds", 1),
            max_attempts=r.get("MaxAttempts", 3),
            backoff_rate=r.get("BackoffRate", 2.0),
        )
        for r in data.get("Retry", [])
    ]


def _parse_catch_list(data: dict) -> list[CatchConfig]:
    """Parse the Catch array from a state definition."""
    return [
        CatchConfig(
            error_equals=c["ErrorEquals"],
            next_state=c["Next"],
            result_path=c.get("ResultPath", "$.Error"),
        )
        for c in data.get("Catch", [])
    ]


def _parse_task_state(name: str, data: dict) -> TaskState:
    """Parse a Task state definition."""
    return TaskState(
        name=name,
        resource=data["Resource"],
        next_state=data.get("Next"),
        end=data.get("End", False),
        input_path=data.get("InputPath", "$"),
        output_path=data.get("OutputPath", "$"),
        result_path=data.get("ResultPath", "$"),
        parameters=data.get("Parameters"),
        result_selector=data.get("ResultSelector"),
        timeout_seconds=data.get("TimeoutSeconds"),
        retry=_parse_retry_list(data),
        catch=_parse_catch_list(data),
        comment=data.get("Comment"),
    )


def _parse_choice_state(name: str, data: dict) -> ChoiceState:
    """Parse a Choice state definition."""
    choices = [_parse_choice_rule(rule) for rule in data.get("Choices", [])]
    return ChoiceState(
        name=name,
        choices=choices,
        default=data.get("Default"),
        input_path=data.get("InputPath", "$"),
        output_path=data.get("OutputPath", "$"),
        comment=data.get("Comment"),
    )


def _parse_choice_rule(rule: dict) -> ChoiceRule:
    """Parse a single choice rule, including combinators."""
    next_state = rule.get("Next", "")

    if "And" in rule:
        return ChoiceRule(
            next_state=next_state,
            and_rules=[_parse_choice_rule(r) for r in rule["And"]],
        )
    if "Or" in rule:
        return ChoiceRule(
            next_state=next_state,
            or_rules=[_parse_choice_rule(r) for r in rule["Or"]],
        )
    if "Not" in rule:
        return ChoiceRule(
            next_state=next_state,
            not_rule=_parse_choice_rule(rule["Not"]),
        )

    variable = rule.get("Variable")
    operator, value = _extract_comparison(rule)
    return ChoiceRule(
        next_state=next_state,
        variable=variable,
        comparison_operator=operator,
        comparison_value=value,
    )


def _extract_comparison(rule: dict) -> tuple[str | None, Any]:
    """Extract the comparison operator and value from a choice rule dict."""
    comparison_ops = [
        "StringEquals",
        "StringGreaterThan",
        "StringLessThan",
        "StringGreaterThanEquals",
        "StringLessThanEquals",
        "NumericEquals",
        "NumericGreaterThan",
        "NumericLessThan",
        "NumericGreaterThanEquals",
        "NumericLessThanEquals",
        "BooleanEquals",
        "IsPresent",
        "IsNull",
        "IsString",
        "IsNumeric",
        "IsBoolean",
        "TimestampEquals",
        "TimestampGreaterThan",
        "TimestampLessThan",
        "TimestampGreaterThanEquals",
        "TimestampLessThanEquals",
    ]
    for op in comparison_ops:
        if op in rule:
            return op, rule[op]
    return None, None


def _parse_wait_state(name: str, data: dict) -> WaitState:
    """Parse a Wait state definition."""
    return WaitState(
        name=name,
        next_state=data.get("Next"),
        end=data.get("End", False),
        seconds=data.get("Seconds"),
        timestamp=data.get("Timestamp"),
        seconds_path=data.get("SecondsPath"),
        timestamp_path=data.get("TimestampPath"),
        input_path=data.get("InputPath", "$"),
        output_path=data.get("OutputPath", "$"),
        comment=data.get("Comment"),
    )


def _parse_parallel_state(name: str, data: dict) -> ParallelState:
    """Parse a Parallel state definition."""
    branches = [_parse_state_machine_dict(b) for b in data.get("Branches", [])]
    return ParallelState(
        name=name,
        branches=branches,
        next_state=data.get("Next"),
        end=data.get("End", False),
        input_path=data.get("InputPath", "$"),
        output_path=data.get("OutputPath", "$"),
        result_path=data.get("ResultPath", "$"),
        result_selector=data.get("ResultSelector"),
        retry=_parse_retry_list(data),
        catch=_parse_catch_list(data),
        comment=data.get("Comment"),
    )


def _parse_map_state(name: str, data: dict) -> MapState:
    """Parse a Map state definition."""
    iterator_data = data.get("Iterator")
    iterator = _parse_state_machine_dict(iterator_data) if iterator_data else None
    return MapState(
        name=name,
        iterator=iterator,
        items_path=data.get("ItemsPath", "$"),
        max_concurrency=data.get("MaxConcurrency", 0),
        next_state=data.get("Next"),
        end=data.get("End", False),
        input_path=data.get("InputPath", "$"),
        output_path=data.get("OutputPath", "$"),
        result_path=data.get("ResultPath", "$"),
        parameters=data.get("Parameters"),
        result_selector=data.get("ResultSelector"),
        retry=_parse_retry_list(data),
        catch=_parse_catch_list(data),
        comment=data.get("Comment"),
    )


def _parse_pass_state(name: str, data: dict) -> PassState:
    """Parse a Pass state definition."""
    return PassState(
        name=name,
        result=data.get("Result"),
        next_state=data.get("Next"),
        end=data.get("End", False),
        input_path=data.get("InputPath", "$"),
        output_path=data.get("OutputPath", "$"),
        result_path=data.get("ResultPath", "$"),
        parameters=data.get("Parameters"),
        comment=data.get("Comment"),
    )


def _parse_succeed_state(name: str, data: dict) -> SucceedState:
    """Parse a Succeed state definition."""
    return SucceedState(
        name=name,
        input_path=data.get("InputPath", "$"),
        output_path=data.get("OutputPath", "$"),
        comment=data.get("Comment"),
    )


def _parse_fail_state(name: str, data: dict) -> FailState:
    """Parse a Fail state definition."""
    return FailState(
        name=name,
        error=data.get("Error"),
        cause=data.get("Cause"),
        comment=data.get("Comment"),
    )
