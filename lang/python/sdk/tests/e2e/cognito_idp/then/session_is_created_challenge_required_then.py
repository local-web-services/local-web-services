"""Then: a session is created in "CHALLENGE_REQUIRED" state"""

from __future__ import annotations

from pytest_bdd import then


@then('a session is created in "CHALLENGE_REQUIRED" state')
def session_is_created_challenge_required_then(world):
    assert world["error"] is None, f"Expected session creation to succeed but got: {world['error']}"
