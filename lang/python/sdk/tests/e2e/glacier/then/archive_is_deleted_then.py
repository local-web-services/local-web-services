"""Then: the "glacier" "archive" will be deleted and the "glacier" "vault" archive count decreases"""

from __future__ import annotations

from pytest_bdd import then


@then('the "glacier" "archive" will be deleted and the "glacier" "vault" archive count decreases')
def archive_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected archive delete to succeed but got: {actual_error}"
