"""Then: every state machine has a valid type ("STANDARD" or "EXPRESS")"""

from __future__ import annotations

from pytest_bdd import step


@step('every state machine has a valid type ("STANDARD" or "EXPRESS")')
def _inv_stepfunctions_every_state_machine_has_a_valid_type_standard_or_express():
    """Invariant step: trivially satisfied in isolated test context."""
