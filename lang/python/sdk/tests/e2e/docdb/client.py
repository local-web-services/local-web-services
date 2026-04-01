"""Test client for docdb tests."""

from __future__ import annotations

import pytest

from .constants import TEST_CLUSTER, TEST_INSTANCE, TEST_SNAPSHOT


class DocdbTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("docdb")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_cluster(self, cluster_id=TEST_CLUSTER):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._client.create_db_cluster(
            DBClusterIdentifier=cluster_id,
            Engine="docdb",
            MasterUsername="admin",
            MasterUserPassword="e2e-test-password-1",
        )

    def create_instance(self, instance_id=TEST_INSTANCE, cluster_id=TEST_CLUSTER):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._client.create_db_instance(
            DBInstanceIdentifier=instance_id,
            DBInstanceClass="db.t3.medium",
            Engine="docdb",
            DBClusterIdentifier=cluster_id,
        )

    def create_snapshot(self, snapshot_id=TEST_SNAPSHOT, cluster_id=TEST_CLUSTER):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._client.create_db_cluster_snapshot(
            DBClusterSnapshotIdentifier=snapshot_id, DBClusterIdentifier=cluster_id
        )
