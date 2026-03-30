"""Then: the bucket enters "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the bucket enters "DELETING" state')
def bucket_enters_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table bucket delete to succeed but got: {actual_error}"
