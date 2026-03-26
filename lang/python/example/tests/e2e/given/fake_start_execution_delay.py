"""Given: fake_start_execution_delay"""

from __future__ import annotations

from pytest_bdd import given, parsers

from ..constants import ScenarioContext


@given(
    parsers.parse(
        'StartExecution is faked with a 10ms delay returning execution ARN "{execution_arn}"'
    )
)
def fake_start_execution_delay(ctx: ScenarioContext, execution_arn: str) -> None:
    ctx.fake_execution_arn = execution_arn
    ctx.sfn_fake_builder = ctx.session.fake("stepfunctions")
    ctx.sfn_fake_builder.operation("start-execution").respond(
        body={
            "executionArn": execution_arn,
            "startDate": 1704067200.0,
        },
        delay_ms=10,
    )
