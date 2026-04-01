"""Given: shards are reallocated across nodes in an active "elasticsearch" "domain" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('shards are reallocated across nodes in an active "elasticsearch" "domain"')
def elasticsearch_seq_shards_reallocated():
    pytest.skip("Cannot simulate shard reallocation in lws")
