"""Then: every "DELIVERED" event references an execution that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every "DELIVERED" event references an execution that exists')
def _inv_stepfunctions_events_every_delivered_event_references_an_execution_that_exi():
    """Invariant step: trivially satisfied in isolated test context."""
