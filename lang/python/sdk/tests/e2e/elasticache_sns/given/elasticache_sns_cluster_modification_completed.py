"""Given: the "elasticache" "cluster" modification completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticache" "cluster" modification completes')
def elasticache_sns_cluster_modification_completed():
    pytest.skip("Cannot trigger internal ElastiCache cluster modification completion in lws")
