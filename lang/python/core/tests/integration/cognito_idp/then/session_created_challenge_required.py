"""Then: a session is created in "CHALLENGE_REQUIRED" state"""

from __future__ import annotations

from pytest_bdd import then


@then('a session is created in "CHALLENGE_REQUIRED" state')
def session_created_challenge_required(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected initiate-auth to succeed but got: {actual_error}"
    actual_result = world["result"]
    assert (
        "AuthenticationResult" in actual_result or "ChallengeName" in actual_result
    ), f"Expected auth result or challenge in response but got: {actual_result}"
