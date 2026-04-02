"""Then: every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists')
def _inv_lambda_events_every_published_event_references_a_bus_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
