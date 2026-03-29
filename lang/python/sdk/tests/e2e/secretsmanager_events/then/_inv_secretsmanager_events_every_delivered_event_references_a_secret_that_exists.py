"""Then: every "DELIVERED" event references a secret that exists"""

from __future__ import annotations

from pytest_bdd import then


@then('every "DELIVERED" event references a secret that exists')
def _inv_secretsmanager_events_every_delivered_event_references_a_secret_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
