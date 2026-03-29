"""Given: log capture is active"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import ScenarioContext


@given("log capture is active")
def log_capture_is_active(ctx: ScenarioContext) -> None:
    cm = ctx.session.capture_logs()
    ctx._log_capture_cm = cm
    ctx.log_capture = cm.__enter__()
