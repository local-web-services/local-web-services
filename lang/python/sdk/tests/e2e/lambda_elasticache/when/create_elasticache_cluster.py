"""When: an "elasticache" "cluster" is created"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "elasticache" "cluster" is created')
def create_elasticache_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
