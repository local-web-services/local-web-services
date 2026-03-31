"""When: a "rds" "database instance" is created"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "rds" "database instance" is created')
def create_rds_instance(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
