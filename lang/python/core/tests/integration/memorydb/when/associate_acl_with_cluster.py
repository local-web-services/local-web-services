"""When: an "memorydb" "ACL" is associated with a "memorydb" "cluster" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_ACL_NAME, INT_CLUSTER_NAME


@when('an "memorydb" "ACL" is associated with a "memorydb" "cluster"')
def associate_acl_with_cluster(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.UpdateCluster"},
        json={"ClusterName": INT_CLUSTER_NAME, "ACLName": INT_ACL_NAME},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
