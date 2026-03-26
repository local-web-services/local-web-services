"""When: a database cluster snapshot is created"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database cluster snapshot is created")
def create_db_cluster_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
