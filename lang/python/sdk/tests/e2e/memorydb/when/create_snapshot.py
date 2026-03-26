"""When: a snapshot is created from an available cluster"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import MemorydbTestClient
from ..constants import TEST_CLUSTER, TEST_SNAPSHOT


@when("a snapshot is created from an available cluster")
def create_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = MemorydbTestClient(lws_session).create_snapshot(
            ClusterName=TEST_CLUSTER, SnapshotName=TEST_SNAPSHOT
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
