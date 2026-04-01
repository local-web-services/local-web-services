"""Given: a replica is added to a "elasticache" "replication group" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a replica is added to a "elasticache" "replication group"')
def elasticache_replica_added():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
