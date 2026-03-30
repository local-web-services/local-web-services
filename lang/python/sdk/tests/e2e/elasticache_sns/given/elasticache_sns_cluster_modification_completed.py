"""Given: the cluster modification has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the cluster modification has completed")
def elasticache_sns_cluster_modification_completed():
    pytest.skip("Cannot trigger internal ElastiCache cluster modification completion in lws")
