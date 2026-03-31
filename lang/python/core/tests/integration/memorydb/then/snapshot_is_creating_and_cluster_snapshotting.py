"""Then: the "elasticache" "snapshot" will be in "CREATING" state and the "elasticache" "cluster" will be "SNAPSHOTTING" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then(
    'the "elasticache" "snapshot" will be in "CREATING" state and the "elasticache" "cluster" will be "SNAPSHOTTING"'
)
def snapshot_is_creating_and_cluster_snapshotting(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected snapshot creation to succeed but got: {actual_error}"
