"""Given: an "elasticache" "cluster" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "elasticache" "cluster" deletion completes')
def elasticache_cluster_deletion_completed():
    pytest.skip(
        "Cannot represent a completed ElastiCache cluster deletion as sequence setup in lws"
    )
