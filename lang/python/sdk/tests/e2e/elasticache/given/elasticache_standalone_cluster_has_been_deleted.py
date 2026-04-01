"""Given: a standalone "elasticache" "cluster" is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a standalone "elasticache" "cluster" is deleted')
def elasticache_standalone_cluster_has_been_deleted():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
