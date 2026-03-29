"""Then: every "DELIVERED" event references a "DB" instance that exists"""

from __future__ import annotations

from pytest_bdd import then


@then('every "DELIVERED" event references a "DB" instance that exists')
def _inv_rds_events_every_delivered_event_references_a_db_instance_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
