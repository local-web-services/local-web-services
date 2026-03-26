"""Given: a database snapshot has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database snapshot has been deleted")
def a_database_snapshot_has_been_deleted():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
