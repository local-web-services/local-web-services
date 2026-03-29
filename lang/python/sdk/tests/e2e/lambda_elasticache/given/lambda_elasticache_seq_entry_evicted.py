"""Given: ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry')
def lambda_elasticache_seq_entry_evicted():
    pytest.skip("Cannot trigger ElastiCache eviction in lws")
