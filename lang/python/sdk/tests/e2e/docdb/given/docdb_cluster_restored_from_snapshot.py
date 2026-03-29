"""Given: a cluster has been restored from a snapshot"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a cluster has been restored from a snapshot")
def docdb_cluster_restored_from_snapshot():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
