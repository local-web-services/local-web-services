"""Then: the "cognito" "user" attributes are updated"""

from __future__ import annotations

from pytest_bdd import then


@then('the "cognito" "user" attributes are updated')
def user_attributes_are_updated(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected attribute update to succeed but got: {actual_error}"
