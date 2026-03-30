"""Given: a cache cluster modification has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a cache cluster modification has completed")
def elasticache_cluster_modification_completed():
    pytest.skip(
        "Cannot represent a completed ElastiCache cluster modification as sequence setup in lws"
    )
