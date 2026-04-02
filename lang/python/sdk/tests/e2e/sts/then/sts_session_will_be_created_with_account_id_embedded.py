"""Then: the "sts" "session" will be created with the account id embedded in the token"""

from __future__ import annotations

from pytest_bdd import then


@then('the "sts" "session" will be created with the account id embedded in the token')
def sts_session_will_be_created_with_account_id_embedded(world):
    actual_token = world.get("session_token", "")
    expected_account_id = world.get("expected_account_id", "")
    expected_prefix = f"lws-acct-{expected_account_id}-"
    assert actual_token.startswith(
        expected_prefix
    ), f"Expected session token to start with {expected_prefix!r} but got {actual_token!r}"
