"""When: a database instance configuration is modified"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database instance configuration is modified")
def modify_db_instance(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
