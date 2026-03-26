"""Then: the session accepts a second reset without error"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import ScenarioContext


@then("the session accepts a second reset without error")
def session_accepts_second_reset(ctx: ScenarioContext) -> None:
    ctx.session.reset()
