"""Then: no errors will appear in the log capture"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import ScenarioContext


@then("no errors will appear in the log capture")
def no_errors_in_log_capture(ctx: ScenarioContext) -> None:
    assert ctx.log_capture is not None, "log capture is not active"
    ctx.log_capture.assert_no_errors()
