"""Tests for JSONata Assign field variable propagation."""

from __future__ import annotations

from typing import Any

from lws.providers.stepfunctions.asl_parser import parse_definition
from lws.providers.stepfunctions.engine import ExecutionEngine, ExecutionStatus

from ._helpers import FakeCompute


async def _run(definition: dict, input_data: Any = None, compute: Any = None) -> Any:
    """Parse a definition, execute it, and return the execution history."""
    defn = parse_definition(definition)
    engine = ExecutionEngine(defn, compute=compute, max_wait_seconds=0.0)
    return await engine.execute(input_data)


class TestJsonataAssignField:
    async def test_assign_stores_value_accessible_in_downstream_state(self) -> None:
        # Arrange
        expected_output = {"from_var": 42}
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "Store",
            "States": {
                "Store": {
                    "Type": "Pass",
                    "Assign": {"myVar": "{% $states.input.x %}"},
                    "Next": "Read",
                },
                "Read": {
                    "Type": "Pass",
                    "Output": "{% {'from_var': $states.context.variables.myVar} %}",
                    "End": True,
                },
            },
        }

        # Act
        history = await _run(definition, input_data={"x": 42})

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_output = history.output_data
        assert actual_output == expected_output

    async def test_assign_variable_accessible_as_top_level_dollar_name(self) -> None:
        # Arrange
        expected_output = {"from_var": 99}
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "Store",
            "States": {
                "Store": {
                    "Type": "Pass",
                    "Assign": {"myVar": "{% $states.input.x %}"},
                    "Next": "Read",
                },
                "Read": {
                    "Type": "Pass",
                    "Output": "{% {'from_var': $myVar} %}",
                    "End": True,
                },
            },
        }

        # Act
        history = await _run(definition, input_data={"x": 99})

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_output = history.output_data
        assert actual_output == expected_output

    async def test_assign_literal_value_accessible_downstream(self) -> None:
        # Arrange
        expected_label = "fixed"
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "Store",
            "States": {
                "Store": {
                    "Type": "Pass",
                    "Assign": {"label": "fixed"},
                    "Next": "Read",
                },
                "Read": {
                    "Type": "Pass",
                    "Output": "{% {'label': $states.context.variables.label} %}",
                    "End": True,
                },
            },
        }

        # Act
        history = await _run(definition, input_data={})

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_label = history.output_data["label"]
        assert actual_label == expected_label

    async def test_pass_state_assign_states_result_is_null(self) -> None:
        # Arrange
        expected_is_null = True
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "Check",
            "States": {
                "Check": {
                    "Type": "Pass",
                    "Assign": {"isNull": "{% $states.result = null %}"},
                    "Next": "Out",
                },
                "Out": {
                    "Type": "Pass",
                    "Output": "{% {'is_null': $isNull} %}",
                    "End": True,
                },
            },
        }

        # Act
        history = await _run(definition, input_data={"x": 1})

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_is_null = history.output_data["is_null"]
        assert actual_is_null == expected_is_null

    async def test_task_assign_captures_states_result(self) -> None:
        # Arrange
        expected_captured = "task-value"
        task_arn = "arn:aws:lambda:us-east-1:000000000000:function:my-fn"
        compute = FakeCompute({task_arn: {"value": "task-value"}})
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "Call",
            "States": {
                "Call": {
                    "Type": "Task",
                    "Resource": task_arn,
                    "Assign": {"captured": "{% $states.result.value %}"},
                    "Next": "Read",
                },
                "Read": {
                    "Type": "Pass",
                    "Output": "{% {'captured': $captured} %}",
                    "End": True,
                },
            },
        }

        # Act
        history = await _run(definition, input_data={}, compute=compute)

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_captured = history.output_data["captured"]
        assert actual_captured == expected_captured
