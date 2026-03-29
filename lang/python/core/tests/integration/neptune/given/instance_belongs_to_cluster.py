"""Given: the instance belongs to this cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the instance belongs to this cluster")
def instance_belongs_to_cluster(world):
    pytest.skip("Cluster membership tracking is not available in stateless integration tests.")
