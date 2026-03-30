"""Given: a database instance has been deleted without a final snapshot"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance has been deleted without a final snapshot")
def a_database_instance_has_been_deleted_without_final_snapshot():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
