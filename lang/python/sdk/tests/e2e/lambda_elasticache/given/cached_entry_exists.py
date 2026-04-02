"""Given: a "CACHED" "elasticache" "entry" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "CACHED" "elasticache" "entry" existed')
def cached_entry_exists():
    pytest.skip("Cannot pre-populate ElastiCache entries in lws")
