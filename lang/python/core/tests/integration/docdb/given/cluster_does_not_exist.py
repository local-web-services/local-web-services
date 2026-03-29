"""Given: the cluster does not exist"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_CLUSTER_ID, INT_INSTANCE_ID


@given("the cluster does not exist")
def cluster_does_not_exist(client: TestClient):
    """Ensure the cluster is absent — delete instance then cluster if created by a prior step."""
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.DeleteDBInstance"},
        json={"DBInstanceIdentifier": INT_INSTANCE_ID},
    )
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.DeleteDBCluster"},
        json={"DBClusterIdentifier": INT_CLUSTER_ID},
    )
