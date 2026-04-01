"""Then: the "cognito" "session" will be either "AUTHENTICATED" or "CHALLENGE_FAILED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "cognito" "session" will be either "AUTHENTICATED" or "CHALLENGE_FAILED"')
def session_is_authenticated_or_challenge_failed(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected respond-to-challenge to succeed but got: {actual_error}"
