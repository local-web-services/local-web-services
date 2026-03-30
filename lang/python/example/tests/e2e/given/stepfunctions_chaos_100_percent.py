"""Given: stepfunctions chaos is set to 100% error rate"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import ScenarioContext


@given("stepfunctions chaos is set to 100% error rate")
def stepfunctions_chaos_100_percent(ctx: ScenarioContext) -> None:
    ctx.session.chaos("stepfunctions").error_rate(1.0).apply()
