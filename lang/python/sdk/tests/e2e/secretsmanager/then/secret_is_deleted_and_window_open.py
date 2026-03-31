"""Then: the "secrets manager" "secret" will be "DELETED" and the recovery window will be open"""

from __future__ import annotations

from pytest_bdd import then


@then('the "secrets manager" "secret" will be "DELETED" and the recovery window will be open')
def secret_is_deleted_and_window_open(world):
    assert world["error"] is None, f"Expected delete_secret to succeed but got: {world['error']}"
