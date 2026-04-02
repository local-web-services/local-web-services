"""Given: an "elasticache" "parameter group" is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "elasticache" "parameter group" is deleted')
def elasticache_pg_has_been_deleted():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
