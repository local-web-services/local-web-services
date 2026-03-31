"""When: a "memorydb" "cluster" is restored from a "memorydb" "snapshot" """

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SNAPSHOT


@when('a "memorydb" "cluster" is restored from a "memorydb" "snapshot"')
def restore_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = lws_session.client("memorydb").restore_cluster(
            ClusterName="e2e-test-cluster-2",
            SnapshotName=TEST_SNAPSHOT,
            NodeType="db.t4g.small",
            ACLName="open-access",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
