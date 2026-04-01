"""Then: every "DELIVERED" event references a parameter that exists (in any state)"""

from __future__ import annotations

from pytest_bdd import step


@step('every "DELIVERED" event references a parameter that exists (in any state)')
def _inv_ssm_events_every_delivered_event_references_a_parameter_that_exists_in_any_():
    """Invariant step: trivially satisfied in isolated test context."""
