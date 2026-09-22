"""Tests for Catch handler firing on DynamoDB.ConditionalCheckFailedException."""

from __future__ import annotations

from typing import Any

from lws.providers.stepfunctions.asl_parser import parse_definition
from lws.providers.stepfunctions.engine import ExecutionEngine, ExecutionStatus

from ._helpers import FakeConditionalFailCompute


async def _run(definition: dict, input_data: Any = None, compute: Any = None) -> Any:
    """Parse a definition, execute it, and return the execution history."""
    defn = parse_definition(definition)
    engine = ExecutionEngine(defn, compute=compute, max_wait_seconds=0.0)
    return await engine.execute(input_data)


class TestJsonataConditionCatch:
    async def test_catch_handler_fires_on_condition_check_failure(self) -> None:
        # Arrange
        expected_output = {"guarded": True}
        task_arn = "arn:aws:states:::dynamodb:updateItem"
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "Update",
            "States": {
                "Update": {
                    "Type": "Task",
                    "Resource": task_arn,
                    "Arguments": {
                        "TableName": "orders",
                        "Key": {"id": {"S": "1"}},
                        "UpdateExpression": "SET #s = :v",
                        "ConditionExpression": "attribute_exists(nonexistent)",
                    },
                    "Catch": [
                        {
                            "ErrorEquals": ["DynamoDB.ConditionalCheckFailedException"],
                            "Next": "NoOp",
                        }
                    ],
                    "End": True,
                },
                "NoOp": {
                    "Type": "Pass",
                    "Output": "{% {'guarded': true} %}",
                    "End": True,
                },
            },
        }

        # Act
        history = await _run(definition, input_data={}, compute=FakeConditionalFailCompute())

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_output = history.output_data
        assert actual_output == expected_output

    async def test_execution_fails_when_no_catch_for_condition_failure(self) -> None:
        # Arrange
        expected_error = "DynamoDB.ConditionalCheckFailedException"
        task_arn = "arn:aws:states:::dynamodb:updateItem"
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "Update",
            "States": {
                "Update": {
                    "Type": "Task",
                    "Resource": task_arn,
                    "End": True,
                },
            },
        }

        # Act
        history = await _run(definition, input_data={}, compute=FakeConditionalFailCompute())

        # Assert
        assert history.status == ExecutionStatus.FAILED
        actual_error = history.error
        assert actual_error == expected_error
