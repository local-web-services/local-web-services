"""Given: an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster"')
def elasticache_snapshot_created():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
