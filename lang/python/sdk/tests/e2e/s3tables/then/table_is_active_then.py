"""Then: the table is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then


@then('the table is "ACTIVE"')
def table_is_active_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table creation to succeed but got: {actual_error}"
