"""Then: the cache entry will be "CACHED" in the cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cache entry will be "CACHED" in the cluster')
def cache_entry_cached(world):
    pytest.skip("Cannot observe Lambda cache write result in lws")
