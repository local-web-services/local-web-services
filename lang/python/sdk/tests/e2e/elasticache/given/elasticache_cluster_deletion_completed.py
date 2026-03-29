"""Given: a cache cluster deletion has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a cache cluster deletion has completed")
def elasticache_cluster_deletion_completed():
    pytest.skip(
        "Cannot represent a completed ElastiCache cluster deletion as sequence setup in lws"
    )
