"""When: a MemoryDB cluster is created"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import MemorydbTestClient
from ..constants import TEST_CLUSTER


@when("a MemoryDB cluster is created")
def create_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = MemorydbTestClient(lws_session).create_cluster(
            ClusterName=TEST_CLUSTER, NodeType="db.t4g.small", ACLName="open-access"
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
