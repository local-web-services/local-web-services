"""Given: a replica creation in a "elasticache" "replication group" completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a replica creation in a "elasticache" "replication group" completes')
def elasticache_replica_creation_completed():
    pytest.skip(
        "Cannot represent a completed ElastiCache replica creation as sequence setup in lws"
    )
