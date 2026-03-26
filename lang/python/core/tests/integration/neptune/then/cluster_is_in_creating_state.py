"""Then: the cluster is in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the cluster is in "CREATING" state')
def cluster_is_in_creating_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected cluster creation to succeed but got error: {world['error']}"
    actual_status = actual_result.get("DBCluster", {}).get("Status", "")
    expected_valid_statuses = ("creating", "available")
    assert (
        actual_status in expected_valid_statuses
    ), f"Expected cluster status in {expected_valid_statuses} but got: {actual_status!r}"
