"""Test client for neptune tests."""

from __future__ import annotations

from .constants import TEST_CLUSTER, TEST_INSTANCE, TEST_SNAPSHOT


class NeptuneTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("neptune")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_cluster(self, cluster_id=TEST_CLUSTER):
        self._client.create_db_cluster(DBClusterIdentifier=cluster_id, Engine="neptune")

    def create_instance(self, instance_id=TEST_INSTANCE, cluster_id=TEST_CLUSTER):
        self._client.create_db_instance(
            DBInstanceIdentifier=instance_id,
            DBInstanceClass="db.t3.medium",
            Engine="neptune",
            DBClusterIdentifier=cluster_id,
        )

    def create_snapshot(self, snapshot_id=TEST_SNAPSHOT, cluster_id=TEST_CLUSTER):
        self._client.create_db_cluster_snapshot(
            DBClusterSnapshotIdentifier=snapshot_id, DBClusterIdentifier=cluster_id
        )
