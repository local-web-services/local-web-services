"""Then: filtering_logs_by_operation"""

from __future__ import annotations

from pytest_bdd import parsers, then

from ..constants import ScenarioContext


@then(parsers.parse('filtering logs by operation "{operation}" will return entries'))
def filtering_logs_by_operation(ctx: ScenarioContext, operation: str) -> None:
    assert ctx.log_capture is not None, "log capture is not active"
    entries = ctx.log_capture.for_operation(operation)
    assert entries, f"expected for_operation({operation!r}) to return entries but got none"
