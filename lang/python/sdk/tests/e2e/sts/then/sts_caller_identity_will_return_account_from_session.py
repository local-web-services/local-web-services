"""Then: the "sts" "caller identity" will return the account from the session"""

from __future__ import annotations

from pytest_bdd import then


@then('the "sts" "caller identity" will return the account from the session')
def sts_caller_identity_will_return_account_from_session(world):
    actual_account = world.get("result", {}).get("Account")
    expected_account = world.get("expected_account_id", "000000000000")
    assert (
        actual_account == expected_account
    ), f"Expected caller identity account {expected_account!r} but got {actual_account!r}"
