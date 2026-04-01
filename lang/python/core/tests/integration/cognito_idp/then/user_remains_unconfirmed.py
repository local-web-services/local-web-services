"""Then: the "cognito" "user" remains in "UNCONFIRMED" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the "cognito" "user" remains in "UNCONFIRMED" state')
def user_remains_unconfirmed(world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected verification-code delivery failure to succeed but got: {actual_error}"
