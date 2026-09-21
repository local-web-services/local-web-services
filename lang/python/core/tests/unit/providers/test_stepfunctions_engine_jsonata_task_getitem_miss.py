"""Tests for JSONata Task state + Choice branching on DynamoDB getItem miss."""

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


class TestJsonataTaskGetItemMiss:
    async def test_choice_exists_branches_to_miss_when_item_absent(self) -> None:
        # Arrange
        expected_output = {"found": False}
        dynamodb_arn = "arn:aws:states:::dynamodb:getItem"
        # getItem miss returns {} (no Item key) — verifies Bug 3 fix propagates correctly
        compute = FakeCompute({dynamodb_arn: {}})
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "GetItem",
            "States": {
                "GetItem": {
                    "Type": "Task",
                    "Resource": dynamodb_arn,
                    "Assign": {"getResult": "{% $states.result %}"},
                    "Next": "Check",
                },
                "Check": {
                    "Type": "Choice",
                    "Choices": [
                        {
                            "Condition": "{% $exists($getResult.Item) %}",
                            "Next": "Hit",
                        }
                    ],
                    "Default": "Miss",
                },
                "Hit": {
                    "Type": "Pass",
                    "Output": "{% {'found': true} %}",
                    "End": True,
                },
                "Miss": {
                    "Type": "Pass",
                    "Output": "{% {'found': false} %}",
                    "End": True,
                },
            },
        }

        # Act
        history = await _run(definition, input_data={}, compute=compute)

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_output = history.output_data
        assert actual_output == expected_output

    async def test_choice_exists_branches_to_hit_when_item_present(self) -> None:
        # Arrange
        expected_output = {"found": True}
        dynamodb_arn = "arn:aws:states:::dynamodb:getItem"
        # getItem hit returns {"Item": {...}}
        compute = FakeCompute({dynamodb_arn: {"Item": {"id": {"S": "42"}}}})
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "GetItem",
            "States": {
                "GetItem": {
                    "Type": "Task",
                    "Resource": dynamodb_arn,
                    "Assign": {"getResult": "{% $states.result %}"},
                    "Next": "Check",
                },
                "Check": {
                    "Type": "Choice",
                    "Choices": [
                        {
                            "Condition": "{% $exists($getResult.Item) %}",
                            "Next": "Hit",
                        }
                    ],
                    "Default": "Miss",
                },
                "Hit": {
                    "Type": "Pass",
                    "Output": "{% {'found': true} %}",
                    "End": True,
                },
                "Miss": {
                    "Type": "Pass",
                    "Output": "{% {'found': false} %}",
                    "End": True,
                },
            },
        }

        # Act
        history = await _run(definition, input_data={}, compute=compute)

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_output = history.output_data
        assert actual_output == expected_output
