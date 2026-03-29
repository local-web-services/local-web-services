"""Given: shards have been reallocated across nodes in an active domain"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("shards have been reallocated across nodes in an active domain")
def elasticsearch_seq_shards_reallocated():
    pytest.skip("Cannot simulate shard reallocation in lws")
