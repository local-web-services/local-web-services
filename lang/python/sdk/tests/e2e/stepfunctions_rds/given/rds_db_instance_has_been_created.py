"""Given: a "RDS" "DB" instance is created"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "RDS" "DB" instance is created')
def rds_db_instance_has_been_created():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
