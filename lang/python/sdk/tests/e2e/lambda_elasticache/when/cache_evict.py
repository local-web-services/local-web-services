"""When: ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry')
def cache_evict(world):
    pytest.skip("Cannot trigger ElastiCache eviction in lws")
