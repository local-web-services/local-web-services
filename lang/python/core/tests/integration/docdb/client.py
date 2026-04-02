"""Test client for docdb tests."""

from __future__ import annotations

from .constants import _DOCDB_TARGET, INT_CLUSTER_ID, INT_INSTANCE_ID, INT_SNAPSHOT_ID


class DocdbTestClient:
    def __init__(self, client):
        self._client = client

    def create_cluster(self, cluster_id: str = INT_CLUSTER_ID) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_DOCDB_TARGET}.CreateDBCluster"},
            json={
                "DBClusterIdentifier": cluster_id,
                "Engine": "docdb",
                "MasterUsername": "admin",
                "MasterUserPassword": "int-test-password",
            },
        )

    def create_instance(
        self, instance_id: str = INT_INSTANCE_ID, cluster_id: str = INT_CLUSTER_ID
    ) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_DOCDB_TARGET}.CreateDBInstance"},
            json={
                "DBInstanceIdentifier": instance_id,
                "DBClusterIdentifier": cluster_id,
                "DBInstanceClass": "db.r5.large",
                "Engine": "docdb",
            },
        )

    def create_snapshot(
        self, snapshot_id: str = INT_SNAPSHOT_ID, cluster_id: str = INT_CLUSTER_ID
    ) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_DOCDB_TARGET}.CreateDBClusterSnapshot"},
            json={
                "DBClusterSnapshotIdentifier": snapshot_id,
                "DBClusterIdentifier": cluster_id,
            },
        )
