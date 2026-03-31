"""Given: a "rds" "snapshot" is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "rds" "snapshot" is deleted')
def a_database_snapshot_has_been_deleted():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
