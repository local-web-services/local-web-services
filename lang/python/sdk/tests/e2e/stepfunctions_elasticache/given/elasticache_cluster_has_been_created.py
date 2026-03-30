"""Given: an ElastiCache cluster has been created and is "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an ElastiCache cluster has been created and is "AVAILABLE"')
def elasticache_cluster_has_been_created():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
