"""When: a "RDS" "DB" instance is created"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "RDS" "DB" instance is created')
def create_rds_db_instance(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
