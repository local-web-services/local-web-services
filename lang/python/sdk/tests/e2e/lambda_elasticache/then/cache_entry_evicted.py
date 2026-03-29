"""Then: the cache entry is "EVICTED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cache entry is "EVICTED"')
def cache_entry_evicted(world):
    pytest.skip("Cannot observe ElastiCache eviction in lws")
