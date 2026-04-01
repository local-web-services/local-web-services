"""Given: a database cluster snapshot has been created"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster snapshot has been created")
def docdb_snapshot_has_been_created():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
