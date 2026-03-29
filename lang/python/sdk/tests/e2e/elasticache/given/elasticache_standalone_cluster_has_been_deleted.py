"""Given: a standalone cache cluster has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a standalone cache cluster has been deleted")
def elasticache_standalone_cluster_has_been_deleted():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
