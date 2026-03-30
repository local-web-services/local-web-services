"""Given: an "RDS" "DB" instance has been created"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "RDS" "DB" instance has been created')
def rds_db_instance_has_been_created():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
