"""Given: the "elasticache" "cluster" does not use the redis engine"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticache" "cluster" does not use the redis engine')
def cluster_does_not_use_redis(world):
    pytest.skip("Cannot create a non-redis cluster without specifying engine in lws.")
