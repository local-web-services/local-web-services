"""Tests for JSONata Choice state Condition field."""

from __future__ import annotations

from typing import Any

from lws.providers.stepfunctions.asl_parser import parse_definition
from lws.providers.stepfunctions.engine import ExecutionEngine, ExecutionStatus


async def _run(definition: dict, input_data: Any = None) -> Any:
    """Parse a definition, execute it, and return the execution history."""
    defn = parse_definition(definition)
    engine = ExecutionEngine(defn, max_wait_seconds=0.0)
    return await engine.execute(input_data)


class TestJsonataChoiceCondition:
    async def test_matching_condition_selects_correct_branch(self) -> None:
        # Arrange
        expected_output = {"branch": "high"}
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "Check",
            "States": {
                "Check": {
                    "Type": "Choice",
                    "Choices": [
                        {
                            "Condition": "{% $states.input.score > 50 %}",
                            "Next": "High",
                        }
                    ],
                    "Default": "Low",
                },
                "High": {
                    "Type": "Pass",
                    "Output": "{% {'branch': 'high'} %}",
                    "End": True,
                },
                "Low": {
                    "Type": "Pass",
                    "Output": "{% {'branch': 'low'} %}",
                    "End": True,
                },
            },
        }

        # Act
        history = await _run(definition, input_data={"score": 75})

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_output = history.output_data
        assert actual_output == expected_output

    async def test_non_matching_condition_falls_through_to_default(self) -> None:
        # Arrange
        expected_output = {"branch": "low"}
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "Check",
            "States": {
                "Check": {
                    "Type": "Choice",
                    "Choices": [
                        {
                            "Condition": "{% $states.input.score > 50 %}",
                            "Next": "High",
                        }
                    ],
                    "Default": "Low",
                },
                "High": {
                    "Type": "Pass",
                    "Output": "{% {'branch': 'high'} %}",
                    "End": True,
                },
                "Low": {
                    "Type": "Pass",
                    "Output": "{% {'branch': 'low'} %}",
                    "End": True,
                },
            },
        }

        # Act
        history = await _run(definition, input_data={"score": 30})

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_output = history.output_data
        assert actual_output == expected_output
