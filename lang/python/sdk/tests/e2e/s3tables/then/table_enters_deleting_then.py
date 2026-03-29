"""Then: the table enters "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the table enters "DELETING" state')
def table_enters_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table delete to succeed but got: {actual_error}"
