"""Given: a shard failover is triggered on a multi-"AZ" "memorydb" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a shard failover is triggered on a multi-"AZ" "memorydb" "cluster"')
def memorydb_shard_failover_triggered_seq():
    pytest.skip("Cannot trigger internal MemoryDB shard failover in lws")
