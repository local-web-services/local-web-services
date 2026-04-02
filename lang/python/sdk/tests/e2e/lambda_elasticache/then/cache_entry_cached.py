"""Then: the "elasticache" "cache" "entry" will be "CACHED" in the "elasticache" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "elasticache" "cache" "entry" will be "CACHED" in the "elasticache" "cluster"')
def cache_entry_cached(world):
    pytest.skip("Cannot observe Lambda cache write result in lws")
