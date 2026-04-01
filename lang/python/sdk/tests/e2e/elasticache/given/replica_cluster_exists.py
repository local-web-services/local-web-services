"""Given: a replica "elasticache" "cluster" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a replica "elasticache" "cluster" existed')
def replica_cluster_exists():
    pytest.skip("Cannot create replica cluster configuration in lws")
