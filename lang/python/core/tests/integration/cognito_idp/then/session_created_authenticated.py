"""Then: a session is created in "AUTHENTICATED" state"""

from __future__ import annotations

from pytest_bdd import then


@then('a session is created in "AUTHENTICATED" state')
def session_created_authenticated(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected admin auth to succeed but got: {actual_error}"
    actual_result = world["result"]
    assert (
        "AuthenticationResult" in actual_result or "Session" in actual_result
    ), f"Expected AuthenticationResult or Session in response but got: {actual_result}"
