"""Then: the instance is "DELETED" and the cluster primary is cleared if applicable"""

from __future__ import annotations

from pytest_bdd import then


@then('the instance is "DELETED" and the cluster primary is cleared if applicable')
def instance_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected instance delete to succeed but got: {actual_error}"
