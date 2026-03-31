"""Then: the "cognito" "session" will be in "EXPIRED" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the "cognito" "session" will be in "EXPIRED" state')
def session_is_expired_then(world):
    assert world["error"] is None, f"Expected session expiry to succeed but got: {world['error']}"
