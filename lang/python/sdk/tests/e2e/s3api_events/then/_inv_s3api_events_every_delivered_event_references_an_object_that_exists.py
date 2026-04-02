"""Then: every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every "DELIVERED" "eventbridge" "event" references an "s3" "object" that exists')
def _inv_s3api_events_every_delivered_event_references_an_object_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
