"""Tests for JSONata Arguments evaluation inside Parallel branches."""

from __future__ import annotations

from typing import Any

from lws.providers.stepfunctions.asl_parser import parse_definition
from lws.providers.stepfunctions.engine import ExecutionEngine, ExecutionStatus

from ._helpers import CapturingCompute


async def _run(definition: dict, input_data: Any = None, compute: Any = None) -> Any:
    """Parse a definition, execute it, and return the execution history."""
    defn = parse_definition(definition)
    engine = ExecutionEngine(defn, compute=compute, max_wait_seconds=0.0)
    return await engine.execute(input_data)


class TestJsonataParallelArguments:
    async def test_parallel_branch_task_arguments_are_evaluated(self) -> None:
        # Arrange
        task_arn = "arn:aws:lambda:us-east-1:000000000000:function:my-fn"
        expected_payload = {"message": "hello"}
        received_payloads: list[Any] = []
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "Par",
            "States": {
                "Par": {
                    "Type": "Parallel",
                    "Branches": [
                        {
                            "StartAt": "Call",
                            "States": {
                                "Call": {
                                    "Type": "Task",
                                    "Resource": task_arn,
                                    "Arguments": {"message": "hello"},
                                    "End": True,
                                }
                            },
                        }
                    ],
                    "End": True,
                }
            },
        }

        # Act
        history = await _run(
            definition,
            input_data={"irrelevant": "raw-input"},
            compute=CapturingCompute(received_payloads, return_value={"ok": True}),
        )

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_payload = received_payloads[0]
        assert actual_payload == expected_payload

    async def test_parallel_branch_task_evaluates_jsonata_expression_in_arguments(self) -> None:
        # Arrange
        task_arn = "arn:aws:lambda:us-east-1:000000000000:function:my-fn"
        expected_table_name = "my-table"
        received_payloads: list[Any] = []
        definition = {
            "QueryLanguage": "JSONata",
            "StartAt": "Par",
            "States": {
                "Par": {
                    "Type": "Parallel",
                    "Branches": [
                        {
                            "StartAt": "Call",
                            "States": {
                                "Call": {
                                    "Type": "Task",
                                    "Resource": task_arn,
                                    "Arguments": {"TableName": "{% $states.input.table %}"},
                                    "End": True,
                                }
                            },
                        }
                    ],
                    "End": True,
                }
            },
        }

        # Act
        history = await _run(
            definition,
            input_data={"table": "my-table"},
            compute=CapturingCompute(received_payloads),
        )

        # Assert
        assert history.status == ExecutionStatus.SUCCEEDED
        actual_table_name = received_payloads[0]["TableName"]
        assert actual_table_name == expected_table_name
