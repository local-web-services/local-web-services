"""Test client for memorydb tests."""

from __future__ import annotations

import pytest

from .constants import TEST_ACL, TEST_CLUSTER, TEST_SNAPSHOT, TEST_USER


class MemorydbTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("memorydb")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_cluster(self, cluster_id=TEST_CLUSTER):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._client.create_cluster(
            ClusterName=cluster_id, NodeType="db.t4g.small", ACLName="open-access"
        )

    def create_snapshot(self, snapshot_id=TEST_SNAPSHOT, cluster_id=TEST_CLUSTER):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._client.create_snapshot(ClusterName=cluster_id, SnapshotName=snapshot_id)

    def create_user(self, user_id=TEST_USER):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._client.create_user(
            UserName=user_id,
            AuthenticationMode={"Type": "no-password"},
            AccessString="on ~* &* +@all",
        )

    def create_acl(self, acl_id=TEST_ACL):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._client.create_acl(ACLName=acl_id)
