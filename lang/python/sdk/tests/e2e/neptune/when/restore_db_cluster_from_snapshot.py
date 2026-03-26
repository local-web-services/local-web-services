"""When: a cluster is restored from a snapshot"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a cluster is restored from a snapshot")
def restore_db_cluster_from_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
