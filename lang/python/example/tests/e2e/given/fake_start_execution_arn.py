"""Given: fake_start_execution_arn"""

from __future__ import annotations

from pytest_bdd import given, parsers

from ..constants import ScenarioContext


@given(parsers.parse('StartExecution is faked to return execution ARN "{execution_arn}"'))
def fake_start_execution_arn(ctx: ScenarioContext, execution_arn: str) -> None:
    ctx.fake_execution_arn = execution_arn
    ctx.sfn_fake_builder = ctx.session.fake("stepfunctions")
    ctx.sfn_fake_builder.operation("start-execution").respond(
        body={
            "executionArn": execution_arn,
            "startDate": 1704067200.0,
        }
    )
