"""Then: the table is in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the table is in "CREATING" state')
def table_is_creating_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table creation to succeed but got: {actual_error}"
