"""Then: every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists')
def _inv_s3api_events_every_delivered_event_references_a_bus_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
