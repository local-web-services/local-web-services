"""Given: an "elasticache" "snapshot" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "elasticache" "snapshot" finishes creating')
def elasticache_snapshot_finished_creating():
    pytest.skip(
        "Cannot represent a completed ElastiCache snapshot creation as sequence setup in lws"
    )
