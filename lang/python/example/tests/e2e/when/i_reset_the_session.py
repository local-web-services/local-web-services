"""When: I reset the session"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import ScenarioContext


@when("I reset the session")
def i_reset_the_session(ctx: ScenarioContext) -> None:
    ctx.session.reset()
