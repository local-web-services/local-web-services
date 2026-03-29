"""Then: filtering_logs_by_service"""

from __future__ import annotations

from pytest_bdd import parsers, then

from ..constants import ScenarioContext


@then(parsers.parse('filtering logs by service "{service}" will return entries'))
def filtering_logs_by_service(ctx: ScenarioContext, service: str) -> None:
    assert ctx.log_capture is not None, "log capture is not active"
    entries = ctx.log_capture.for_service(service)
    assert entries, f"expected for_service({service!r}) to return entries but got none"
