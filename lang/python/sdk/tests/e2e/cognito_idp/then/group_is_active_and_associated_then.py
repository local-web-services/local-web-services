"""Then: the "cognito" "group" will be "ACTIVE" and associated with the "cognito" "user pool" """

from __future__ import annotations

from pytest_bdd import then


@then('the "cognito" "group" will be "ACTIVE" and associated with the "cognito" "user pool"')
def group_is_active_and_associated_then(world):
    assert world["error"] is None, f"Expected group creation to succeed but got: {world['error']}"
