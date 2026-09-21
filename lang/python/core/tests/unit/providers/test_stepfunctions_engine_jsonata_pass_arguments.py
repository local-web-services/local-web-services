"""Tests for JSONata Pass state Arguments field."""

from __future__ import annotations

from typing import Any

from lws.providers.stepfunctions.asl_parser import parse_definition
from lws.providers.stepfunctions.engine import ExecutionEngine, ExecutionStatus


async def _run(definition: dict, input_data: Any = None) -> Any:
    """Parse a definition, execute it, and return the execution history."""
    defn = parse_definition(definition)
    engine = ExecutionEngine(defn, max_wait_seconds=0.0)
    return await engine.execute(input_data)


class TestJsonataPassStateArguments:
    async def test_arguments_expression_replaces_input_field(self) -> None:
        # Arrange
        expected_name = "Alice"
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "P",
            "States": {
                "P": {
                    "Type": "Pass",
                    "Arguments": {"name": "{% $states.input.raw_name %}"},
                    "End": True,
                }
            },
        }

        # Act
        history = await _run(definition, input_data={"raw_name": expected_name})

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_name = history.output_data["name"]
        assert actual_name == expected_name

    async def test_arguments_literal_value_passes_through(self) -> None:
        # Arrange
        expected_label = "fixed-label"
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "P",
            "States": {
                "P": {
                    "Type": "Pass",
                    "Arguments": {"label": expected_label},
                    "End": True,
                }
            },
        }

        # Act
        history = await _run(definition, input_data={"ignored": 1})

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_label = history.output_data["label"]
        assert actual_label == expected_label

    async def test_arguments_string_concatenation(self) -> None:
        # Arrange
        expected_greeting = "hello Alice"
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "P",
            "States": {
                "P": {
                    "Type": "Pass",
                    "Arguments": {"greeting": "{% 'hello ' & $states.input.name %}"},
                    "End": True,
                }
            },
        }

        # Act
        history = await _run(definition, input_data={"name": "Alice"})

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_greeting = history.output_data["greeting"]
        assert actual_greeting == expected_greeting
