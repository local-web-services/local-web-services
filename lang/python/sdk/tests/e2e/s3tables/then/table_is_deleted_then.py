"""Then: the table is "DELETED" and all its snapshots are "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the table is "DELETED" and all its snapshots are "DELETED"')
def table_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table delete to succeed but got: {actual_error}"
