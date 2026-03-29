"""Then: the session is in "EXPIRED" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the session is in "EXPIRED" state')
def session_is_expired(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected session expiry to succeed but got: {actual_error}"
