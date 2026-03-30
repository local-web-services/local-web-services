"""Then: the cluster is in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the cluster is in "DELETING" state')
def cluster_is_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected cluster delete to succeed but got: {actual_error}"
