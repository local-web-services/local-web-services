"""Given: a cache snapshot deletion has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a cache snapshot deletion has completed")
def elasticache_snapshot_deletion_completed():
    pytest.skip(
        "Cannot represent a completed ElastiCache snapshot deletion as sequence setup in lws"
    )
