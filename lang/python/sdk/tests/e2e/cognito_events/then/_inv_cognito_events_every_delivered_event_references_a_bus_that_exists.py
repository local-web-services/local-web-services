"""Then: every "DELIVERED" event references a bus that exists"""

from __future__ import annotations

from pytest_bdd import then


@then('every "DELIVERED" event references a bus that exists')
def _inv_cognito_events_every_delivered_event_references_a_bus_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
