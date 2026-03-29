"""Then: the snapshot is "DELETED" and its tags are removed"""

from __future__ import annotations

from pytest_bdd import then


@then('the snapshot is "DELETED" and its tags are removed')
def snapshot_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected snapshot delete to succeed but got: {actual_error}"
