"""Given: a snapshot has been created from an available redis cache cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a snapshot has been created from an available redis cache cluster")
def elasticache_snapshot_created():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
