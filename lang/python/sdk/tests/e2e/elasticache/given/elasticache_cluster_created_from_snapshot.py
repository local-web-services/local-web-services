"""Given: a cache cluster has been created from a snapshot"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a cache cluster has been created from a snapshot")
def elasticache_cluster_created_from_snapshot():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
