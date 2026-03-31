"""Given: the "elasticache" "cluster" was "SNAPSHOTTING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticache" "cluster" was "SNAPSHOTTING"')
def cluster_is_snapshotting(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
