"""Then: recent logs will be non-empty"""

from __future__ import annotations

import time

from pytest_bdd import then

from ..constants import ScenarioContext


@then("recent logs will be non-empty")
def recent_logs_non_empty(ctx: ScenarioContext) -> None:
    deadline = time.time() + 5.0
    while time.time() < deadline:
        logs = ctx.session.recent_logs()
        if logs:
            return
        time.sleep(0.05)
    raise AssertionError("expected non-empty recent logs after activity")
