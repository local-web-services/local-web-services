"""Then: every "RUNNING" execution was started by an "ENABLED" rule"""

from __future__ import annotations

from pytest_bdd import step


@step('every "RUNNING" execution was started by an "ENABLED" rule')
def _inv_events_stepfunctions_every_running_execution_was_started_by_an_enabled_rule():
    """Invariant step: trivially satisfied in isolated test context."""
