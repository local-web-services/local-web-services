"""Given: a replica creation in a replication group has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a replica creation in a replication group has completed")
def elasticache_replica_creation_completed():
    pytest.skip(
        "Cannot represent a completed ElastiCache replica creation as sequence setup in lws"
    )
