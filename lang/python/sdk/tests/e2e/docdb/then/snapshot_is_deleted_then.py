"""Then: the "documentdb" "SNAPSHOT" will be "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "documentdb" "SNAPSHOT" will be "DELETED"')
def snapshot_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected snapshot delete to succeed but got: {actual_error}"
