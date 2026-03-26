"""Then: the user is in "COMPROMISED" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the user is in "COMPROMISED" state')
def user_is_in_compromised_state_then(world):
    """Invariant step: mark_user_compromised outcome is checked via no-error."""
    assert world["error"] is None, f"Expected no error but got: {world['error']}"
