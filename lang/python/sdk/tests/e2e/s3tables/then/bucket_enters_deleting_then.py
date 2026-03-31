"""Then: the "s3 tables" "bucket" will be in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the "s3 tables" "bucket" will be in "DELETING" state')
def bucket_enters_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table bucket delete to succeed but got: {actual_error}"
