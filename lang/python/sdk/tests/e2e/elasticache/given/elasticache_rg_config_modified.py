"""Given: a "elasticache" "replication group" configuration is modified"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "elasticache" "replication group" configuration is modified')
def elasticache_rg_config_modified():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
