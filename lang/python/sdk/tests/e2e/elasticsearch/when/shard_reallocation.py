"""When: shards are reallocated across nodes in an active "elasticsearch" "domain" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('shards are reallocated across nodes in an active "elasticsearch" "domain"')
def shard_reallocation(lws_session, world):
    pytest.skip("Cannot trigger internal shard reallocation in lws")
