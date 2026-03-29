"""Test client for rds tests."""

from __future__ import annotations

import pytest

from .constants import TEST_DB, TEST_SNAPSHOT


class RdsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("rds")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_db_instance(self, instance_id=TEST_DB):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._client.create_db_instance(
            DBInstanceIdentifier=instance_id,
            DBInstanceClass="db.t3.micro",
            Engine="mysql",
            MasterUsername="admin",
            MasterUserPassword="e2e-test-password-1",
        )

    def create_snapshot(self, snapshot_id=TEST_SNAPSHOT, instance_id=TEST_DB):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._client.create_db_snapshot(
            DBSnapshotIdentifier=snapshot_id, DBInstanceIdentifier=instance_id
        )
