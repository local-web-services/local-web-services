"""Then: a "cognito" "session" will be created in "AUTHENTICATED" state"""

from __future__ import annotations

from pytest_bdd import then


@then('a "cognito" "session" will be created in "AUTHENTICATED" state')
def session_is_created_authenticated_then(world):
    assert world["error"] is None, f"Expected session creation to succeed but got: {world['error']}"
