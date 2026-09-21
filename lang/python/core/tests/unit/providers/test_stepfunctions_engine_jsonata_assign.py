"""Tests for JSONata Assign field variable propagation."""

from __future__ import annotations

from typing import Any

from lws.providers.stepfunctions.asl_parser import parse_definition
from lws.providers.stepfunctions.engine import ExecutionEngine, ExecutionStatus


async def _run(definition: dict, input_data: Any = None) -> Any:
    """Parse a definition, execute it, and return the execution history."""
    defn = parse_definition(definition)
    engine = ExecutionEngine(defn, max_wait_seconds=0.0)
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
