"""When: the "elasticache" "cluster" modification completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "elasticache" "cluster" modification completes')
def cluster_modification_completes(world):
    pytest.skip("Cannot trigger internal ElastiCache cluster modification completion in lws")
