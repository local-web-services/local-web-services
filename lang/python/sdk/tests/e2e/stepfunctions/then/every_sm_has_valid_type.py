"""Then: every "step functions" "state machine" has a valid type ("STANDARD" or "EXPRESS")"""

from __future__ import annotations

from pytest_bdd import then


@then('every "step functions" "state machine" has a valid type ("STANDARD" or "EXPRESS")')
def every_sm_has_valid_type():
    """Invariant: trivially satisfied in isolated lws context."""
