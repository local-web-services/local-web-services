"""When: a shard failover is triggered on a multi-"AZ" cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a shard failover is triggered on a multi-"AZ" cluster')
def shard_failover(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB shard failover in lws")
