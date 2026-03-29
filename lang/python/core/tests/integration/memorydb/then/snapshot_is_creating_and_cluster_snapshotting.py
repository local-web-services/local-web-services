"""Then: the snapshot is in "CREATING" state and the cluster is "SNAPSHOTTING" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the snapshot is in "CREATING" state and the cluster is "SNAPSHOTTING"')
def snapshot_is_creating_and_cluster_snapshotting(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected snapshot creation to succeed but got: {actual_error}"
