"""Given: an "elasticache" "snapshot" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "elasticache" "snapshot" deletion completes')
def elasticache_snapshot_deletion_completed():
    pytest.skip(
        "Cannot represent a completed ElastiCache snapshot deletion as sequence setup in lws"
    )
