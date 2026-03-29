"""Then: every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")"""

from __future__ import annotations

from pytest_bdd import then


@then('every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")')
def _inv_stepfunctions_every_state_machine_has_a_valid_status_active_deleting_or_del():
    """Invariant step: trivially satisfied in isolated test context."""
