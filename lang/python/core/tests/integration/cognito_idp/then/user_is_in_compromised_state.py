"""Then: the user is in "COMPROMISED" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the user is in "COMPROMISED" state')
def user_is_in_compromised_state(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected mark-compromised to succeed but got: {actual_error}"
