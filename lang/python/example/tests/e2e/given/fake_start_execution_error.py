"""Given: fake_start_execution_error"""

from __future__ import annotations

from pytest_bdd import given, parsers

from ..constants import ScenarioContext


@given(parsers.parse('StartExecution is faked to return error "{error_code}"'))
def fake_start_execution_error(ctx: ScenarioContext, error_code: str) -> None:
    ctx.session.fake("stepfunctions").operation("start-execution").error(
        error_type=error_code,
        message="Injected error for testing",
    )
