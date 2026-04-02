"""Test client for memorydb tests."""

from __future__ import annotations

from .constants import (
    _MDB_TARGET,
    INT_ACL_NAME,
    INT_CLUSTER_NAME,
    INT_SNAPSHOT_NAME,
    INT_USER_NAME,
)


class MemorydbTestClient:
    def __init__(self, client):
        self._client = client

    def create_cluster(self, name: str = INT_CLUSTER_NAME) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_MDB_TARGET}.CreateCluster"},
            json={"ClusterName": name},
        )

    def create_snapshot(
        self,
        snapshot_name: str = INT_SNAPSHOT_NAME,
        cluster_name: str = INT_CLUSTER_NAME,
    ) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_MDB_TARGET}.CreateSnapshot"},
            json={"ClusterName": cluster_name, "SnapshotName": snapshot_name},
        )

    def create_user(self, user_name: str = INT_USER_NAME) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_MDB_TARGET}.CreateUser"},
            json={
                "UserName": user_name,
                "AuthenticationMode": {"Type": "no-password"},
                "AccessString": "on ~* &* +@all",
            },
        )

    def create_acl(self, acl_name: str = INT_ACL_NAME) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_MDB_TARGET}.CreateACL"},
            json={"ACLName": acl_name},
        )

    def get_cluster_arn(self, name: str = INT_CLUSTER_NAME) -> str:
        r = self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_MDB_TARGET}.DescribeClusters"},
            json={"ClusterName": name},
        )
        clusters = r.json().get("Clusters", [])
        return clusters[0]["ARN"] if clusters else ""
