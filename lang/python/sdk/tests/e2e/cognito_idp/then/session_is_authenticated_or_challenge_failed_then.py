"""Then: the "cognito" "session" will be either "AUTHENTICATED" or "CHALLENGE_FAILED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "cognito" "session" will be either "AUTHENTICATED" or "CHALLENGE_FAILED"')
def session_is_authenticated_or_challenge_failed_then(world):
    assert (
        world["error"] is None
    ), f"Expected auth challenge response to succeed but got: {world['error']}"
