"""Given: the new cluster is not ready"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the new cluster is not ready")
def new_cluster_is_not_ready(world):
    pytest.skip("Blue-green cluster readiness state not available in stateless integration tests.")
