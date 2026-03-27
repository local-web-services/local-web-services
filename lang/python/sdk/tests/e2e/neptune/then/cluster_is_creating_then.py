"""Then: the cluster is in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the cluster is in "CREATING" state')
def cluster_is_creating_then(world):
    expected_error = None
    actual_error = world.get("error")
    assert (
        actual_error is expected_error
    ), f"Expected cluster creation to succeed but got: {actual_error}"
    actual_result = world.get("result")
    expected_field = "DBCluster"
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected {expected_field!r} in result but got: {actual_result}"
