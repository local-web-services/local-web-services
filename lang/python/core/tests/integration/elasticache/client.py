"""Test client for elasticache tests."""

from __future__ import annotations

from .constants import (
    _EC_TARGET,
    INT_CLUSTER_ID,
    INT_PARAM_GROUP_ID,
    INT_RG_ID,
    INT_SNAPSHOT_ID,
    INT_SUBNET_GROUP_ID,
)


class ElasticacheTestClient:
    def __init__(self, client):
        self._client = client

    def create_cluster(self, cluster_id: str = INT_CLUSTER_ID) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_EC_TARGET}.CreateCacheCluster"},
            json={"CacheClusterId": cluster_id},
        )

    def create_replication_group(self, rg_id: str = INT_RG_ID) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_EC_TARGET}.CreateReplicationGroup"},
            json={
                "ReplicationGroupId": rg_id,
                "ReplicationGroupDescription": "int-test-rg",
            },
        )

    def create_snapshot(
        self, snapshot_id: str = INT_SNAPSHOT_ID, cluster_id: str = INT_CLUSTER_ID
    ) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_EC_TARGET}.CreateSnapshot"},
            json={"CacheClusterId": cluster_id, "SnapshotName": snapshot_id},
        )

    def create_param_group(self, pg_id: str = INT_PARAM_GROUP_ID) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_EC_TARGET}.CreateCacheParameterGroup"},
            json={
                "CacheParameterGroupName": pg_id,
                "CacheParameterGroupFamily": "redis6.x",
                "Description": "int-test-pg",
            },
        )

    def create_subnet_group(self, sg_id: str = INT_SUBNET_GROUP_ID) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_EC_TARGET}.CreateCacheSubnetGroup"},
            json={
                "CacheSubnetGroupName": sg_id,
                "CacheSubnetGroupDescription": "int-test-sg",
                "SubnetIds": ["subnet-00000001"],
            },
        )

    def get_cluster_arn(self, cluster_id: str = INT_CLUSTER_ID) -> str:
        r = self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_EC_TARGET}.DescribeCacheClusters"},
            json={"CacheClusterId": cluster_id},
        )
        clusters = r.json().get("CacheClusters", [])
        return clusters[0]["ARN"] if clusters else ""

    def get_rg_arn(self, rg_id: str = INT_RG_ID) -> str:
        r = self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_EC_TARGET}.DescribeReplicationGroups"},
            json={"ReplicationGroupId": rg_id},
        )
        rgs = r.json().get("ReplicationGroups", [])
        return rgs[0]["ARN"] if rgs else ""
