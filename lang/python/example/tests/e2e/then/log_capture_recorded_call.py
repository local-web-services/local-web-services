"""Then: log_capture_recorded_call"""

from __future__ import annotations

from pytest_bdd import parsers, then

from ..constants import ScenarioContext


@then(parsers.parse('the log capture will have recorded a "{service}" "{operation}" call'))
def log_capture_recorded_call(ctx: ScenarioContext, service: str, operation: str) -> None:
    assert ctx.log_capture is not None, "log capture is not active"
    ctx.log_capture.assert_called(service, operation)
