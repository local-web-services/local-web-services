"""When: a cache snapshot is deleted"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ElasticacheTestClient
from ..constants import TEST_SNAPSHOT


@when("a cache snapshot is deleted")
def delete_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = ElasticacheTestClient(lws_session).delete_snapshot(
            SnapshotName=TEST_SNAPSHOT
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
