"""When: a database cluster configuration is modified"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database cluster configuration is modified")
def modify_db_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
