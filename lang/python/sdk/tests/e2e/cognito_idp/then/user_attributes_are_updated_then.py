"""Then: the "cognito" "user" attributes are updated"""

from __future__ import annotations

from pytest_bdd import then


@then('the "cognito" "user" attributes are updated')
def user_attributes_are_updated_then(world):
    assert (
        world["error"] is None
    ), f"Expected attributes update to succeed but got: {world['error']}"
