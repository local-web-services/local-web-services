"""Given: an "elasticache" "cluster" is created and becomes "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "elasticache" "cluster" is created and becomes "AVAILABLE"')
def elasticache_cluster_has_been_created():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
