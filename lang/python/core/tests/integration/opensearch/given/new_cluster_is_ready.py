"""Given: the new "opensearch" "cluster" was ready"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the new "opensearch" "cluster" was ready')
def new_cluster_is_ready(world):
    pytest.skip("Blue-green cluster readiness state not available in stateless integration tests.")
