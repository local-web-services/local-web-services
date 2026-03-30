"""Then: the user remains in "UNCONFIRMED" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the user remains in "UNCONFIRMED" state')
def user_remains_unconfirmed_then(world):
    assert (
        world["error"] is None
    ), f"Expected verification code delivery failure to succeed but got: {world['error']}"
