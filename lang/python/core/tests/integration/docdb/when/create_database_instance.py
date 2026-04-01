"""When: a "documentdb" "instance" is created in an available documentdb cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_CLUSTER_ID, INT_INSTANCE_ID


@when('a "documentdb" "instance" is created in an available documentdb cluster')
def create_database_instance(client: TestClient, world):
    r_check = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.DescribeDBClusters"},
        json={"DBClusterIdentifier": INT_CLUSTER_ID},
    )
    if not r_check.json().get("DBClusters"):
        pytest.skip("lws does not enforce cluster existence when creating a database instance.")
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.CreateDBInstance"},
        json={
            "DBInstanceIdentifier": INT_INSTANCE_ID,
            "DBClusterIdentifier": INT_CLUSTER_ID,
            "DBInstanceClass": "db.r5.large",
            "Engine": "docdb",
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
