"""Test client for elasticache tests."""

from __future__ import annotations

import pytest

from .constants import (
    TEST_CLUSTER,
    TEST_PARAMETER_GROUP,
    TEST_REPLICATION_GROUP,
    TEST_SNAPSHOT,
    TEST_SUBNET_GROUP,
)


class ElasticacheTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("elasticache")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_cluster(self, cluster_id=TEST_CLUSTER, engine="redis"):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._client.create_cache_cluster(
            CacheClusterId=cluster_id,
            CacheNodeType="cache.t3.micro",
            Engine=engine,
            NumCacheNodes=1,
        )

    def create_replication_group(self, rg_id=TEST_REPLICATION_GROUP):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._client.create_replication_group(
            ReplicationGroupId=rg_id,
            ReplicationGroupDescription="e2e test replication group",
            CacheNodeType="cache.t3.micro",
            Engine="redis",
        )

    def create_snapshot(self, snapshot_id=TEST_SNAPSHOT, cluster_id=TEST_CLUSTER):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._client.create_snapshot(SnapshotName=snapshot_id, CacheClusterId=cluster_id)

    def create_parameter_group(self, pg_id=TEST_PARAMETER_GROUP):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._client.create_cache_parameter_group(
            CacheParameterGroupName=pg_id,
            CacheParameterGroupFamily="redis6.x",
            Description="e2e test parameter group",
        )

    def create_subnet_group(self, sg_id=TEST_SUBNET_GROUP):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._client.create_cache_subnet_group(
            CacheSubnetGroupName=sg_id,
            CacheSubnetGroupDescription="e2e test subnet group",
            SubnetIds=["subnet-12345678"],
        )
