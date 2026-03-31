"""When: shards are rebalanced across nodes in an active "opensearch" "domain" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('shards are rebalanced across nodes in an active "opensearch" "domain"')
def shard_rebalancing(lws_session, world):
    pytest.skip("Cannot trigger internal shard rebalancing in lws")
