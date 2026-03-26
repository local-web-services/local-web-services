"""When: a stopped database cluster is started"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a stopped database cluster is started")
def start_db_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
