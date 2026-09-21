"""Tests for JSONata query language scoping (SM-level vs per-state)."""

from __future__ import annotations

from typing import Any

from lws.providers.stepfunctions.asl_parser import parse_definition
from lws.providers.stepfunctions.engine import ExecutionEngine, ExecutionStatus


async def _run(definition: dict, input_data: Any = None) -> Any:
    """Parse a definition, execute it, and return the execution history."""
    defn = parse_definition(definition)
    engine = ExecutionEngine(defn, max_wait_seconds=0.0)
    return await engine.execute(input_data)


class TestJsonataQueryLanguageScoping:
    async def test_sm_level_query_language_applies_to_all_states(self) -> None:
        # Arrange
        expected_value = "from-input"
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "P",
            "States": {
                "P": {
                    "Type": "Pass",
                    "Arguments": {"extracted": "{% $states.input.source %}"},
                    "End": True,
                }
            },
        }

        # Act
        history = await _run(definition, input_data={"source": expected_value})

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_value = history.output_data["extracted"]
        assert actual_value == expected_value

    async def test_per_state_jsonata_overrides_jsonpath_sm(self) -> None:
        # Arrange
        expected_name = "Alice"
        definition = {
            "QueryLanguage": "JSONPath",
            "StartAt": "P",
            "States": {
                "P": {
                    "Type": "Pass",
                    "QueryLanguage": "JSONata",
                    "Arguments": {"name": "{% $states.input.raw %}"},
                    "End": True,
                }
            },
        }

        # Act
        history = await _run(definition, input_data={"raw": expected_name})

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_name = history.output_data["name"]
        assert actual_name == expected_name
