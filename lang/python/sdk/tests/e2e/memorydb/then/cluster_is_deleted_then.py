"""Then: the "memorydb" "cluster" will be "DELETED" and its tags will be removed"""

from __future__ import annotations

from pytest_bdd import then


@then('the "memorydb" "cluster" will be "DELETED" and its tags will be removed')
def cluster_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected cluster delete to succeed but got: {actual_error}"
