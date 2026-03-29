"""Given: fake_describe_execution_succeeded"""

from __future__ import annotations

import json

from pytest_bdd import given, parsers

from ..constants import ScenarioContext


@given(
    parsers.parse(
        'DescribeExecution is faked to return SUCCEEDED with output containing order ID "{order_id}"'  # noqa: E501
    )
)
def fake_describe_execution_succeeded(ctx: ScenarioContext, order_id: str) -> None:
    fake_sm_arn = "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor"
    ctx.sfn_fake_builder.operation("describe-execution").respond(
        body={
            "executionArn": ctx.fake_execution_arn,
            "stateMachineArn": fake_sm_arn,
            "name": "fake-exec",
            "status": "SUCCEEDED",
            "startDate": 1704067200.0,
            "output": json.dumps({"orderId": order_id}),
        }
    )
