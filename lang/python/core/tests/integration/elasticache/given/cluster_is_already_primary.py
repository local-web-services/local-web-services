"""Given: the "elasticache" "cluster" was already the primary"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticache" "cluster" was already the primary')
def cluster_is_already_primary(world):
    pytest.skip("Primary cluster state requires replication group setup not supported here.")
