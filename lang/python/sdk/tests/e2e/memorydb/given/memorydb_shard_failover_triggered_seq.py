"""Given: a shard failover has been triggered on a multi-"AZ" cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a shard failover has been triggered on a multi-"AZ" cluster')
def memorydb_shard_failover_triggered_seq():
    pytest.skip("Cannot trigger internal MemoryDB shard failover in lws")
