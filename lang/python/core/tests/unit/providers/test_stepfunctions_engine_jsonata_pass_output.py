"""Tests for JSONata Pass state Output field."""

from __future__ import annotations

from typing import Any

from lws.providers.stepfunctions.asl_parser import parse_definition
from lws.providers.stepfunctions.engine import ExecutionEngine, ExecutionStatus


async def _run(definition: dict, input_data: Any = None) -> Any:
    """Parse a definition, execute it, and return the execution history."""
    defn = parse_definition(definition)
    engine = ExecutionEngine(defn, max_wait_seconds=0.0)
    return await engine.execute(input_data)


class TestJsonataPassStateOutput:
    async def test_output_expression_produces_final_output(self) -> None:
        # Arrange
        expected_output = {"name": "Alice"}
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "P",
            "States": {
                "P": {
                    "Type": "Pass",
                    "Output": "{% {'name': $states.input.name} %}",
                    "End": True,
                }
            },
        }

        # Act
        history = await _run(definition, input_data={"name": "Alice"})

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_output = history.output_data
        assert actual_output == expected_output
