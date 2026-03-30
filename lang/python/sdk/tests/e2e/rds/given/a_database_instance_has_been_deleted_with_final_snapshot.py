"""Given: a database instance has been deleted with a final snapshot"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance has been deleted with a final snapshot")
def a_database_instance_has_been_deleted_with_final_snapshot():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
