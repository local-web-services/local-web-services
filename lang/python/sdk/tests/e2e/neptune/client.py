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
        try:
            self._client.create_db_cluster(DBClusterIdentifier=cluster_id, Engine="neptune")
        except Exception:
            pass

    def create_instance(self, instance_id=TEST_INSTANCE, cluster_id=TEST_CLUSTER):
        try:
            self._client.create_db_instance(
                DBInstanceIdentifier=instance_id,
                DBInstanceClass="db.t3.medium",
                Engine="neptune",
                DBClusterIdentifier=cluster_id,
            )
        except Exception:
            pass

    def create_snapshot(self, snapshot_id=TEST_SNAPSHOT, cluster_id=TEST_CLUSTER):
        try:
            self._client.create_db_cluster_snapshot(
                DBClusterSnapshotIdentifier=snapshot_id, DBClusterIdentifier=cluster_id
            )
        except Exception:
            pass

    def delete_cluster(self, cluster_id=TEST_CLUSTER):
        try:
            self._client.delete_db_instance(DBInstanceIdentifier=TEST_INSTANCE)
        except Exception:  # noqa: BLE001
            pass
        try:
            self._client.delete_db_cluster(DBClusterIdentifier=cluster_id)
        except Exception:  # noqa: BLE001
            pass

    def stop_cluster(self, cluster_id=TEST_CLUSTER):
        try:
            self._client.stop_db_cluster(DBClusterIdentifier=cluster_id)
        except Exception:  # noqa: BLE001
            pass

    def start_cluster(self, cluster_id=TEST_CLUSTER):
        try:
            self._client.start_db_cluster(DBClusterIdentifier=cluster_id)
        except Exception:  # noqa: BLE001
            pass

    def reboot_instance(self, instance_id=TEST_INSTANCE):
        try:
            self._client.reboot_db_instance(DBInstanceIdentifier=instance_id)
        except Exception:  # noqa: BLE001
            pass
