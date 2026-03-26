"""Given: shards have been rebalanced across nodes in an active domain"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("shards have been rebalanced across nodes in an active domain")
def opensearch_shards_rebalanced_seq():
    pytest.skip("Cannot trigger internal shard rebalancing in lws")
