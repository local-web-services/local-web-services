"""Then: the cache entry will be "EVICTED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cache entry will be "EVICTED"')
def cache_entry_evicted(world):
    pytest.skip("Cannot observe ElastiCache eviction in lws")
