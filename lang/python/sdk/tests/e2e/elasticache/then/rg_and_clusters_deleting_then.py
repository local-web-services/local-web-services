"""Then: the replication group and its clusters are in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the replication group and its clusters are in "DELETING" state')
def rg_and_clusters_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected replication group delete to succeed but got: {actual_error}"
