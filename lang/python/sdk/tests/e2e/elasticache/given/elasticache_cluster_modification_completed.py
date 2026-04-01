"""Given: an "elasticache" "cluster" modification completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "elasticache" "cluster" modification completes')
def elasticache_cluster_modification_completed():
    pytest.skip(
        "Cannot represent a completed ElastiCache cluster modification as sequence setup in lws"
    )
