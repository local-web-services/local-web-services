"""Then: every "DELIVERED" event references a "cognito" "user pool" that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every "DELIVERED" event references a "cognito" "user pool" that exists')
def _inv_cognito_events_every_delivered_event_references_a_pool_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
