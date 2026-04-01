"""When: a replica is added to a "elasticache" "replication group" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a replica is added to a "elasticache" "replication group"')
def add_replica_to_rg(lws_session, world):
    pytest.skip("Cannot add replica to replication group in lws")
