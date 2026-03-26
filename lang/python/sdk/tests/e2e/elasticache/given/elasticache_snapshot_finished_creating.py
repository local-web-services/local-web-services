"""Given: a cache snapshot has finished creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a cache snapshot has finished creating")
def elasticache_snapshot_finished_creating():
    pytest.skip(
        "Cannot represent a completed ElastiCache snapshot creation as sequence setup in lws"
    )
