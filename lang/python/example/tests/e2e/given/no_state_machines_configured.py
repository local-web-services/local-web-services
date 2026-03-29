"""Given: no state machines are configured"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import ScenarioContext


@given("no state machines are configured")
def no_state_machines_configured(ctx: ScenarioContext) -> None:
    ctx.sfn_client = ctx.session.client("stepfunctions")
