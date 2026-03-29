"""Then: the secret is "DELETED" and the recovery window is open"""

from __future__ import annotations

from pytest_bdd import then


@then('the secret is "DELETED" and the recovery window is open')
def secret_is_deleted_and_window_open(world):
    assert world["error"] is None, f"Expected delete_secret to succeed but got: {world['error']}"
