"""Given: the cluster is part of this replication group"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the cluster is part of this replication group")
def cluster_is_part_of_this_rg():
    pytest.skip("Cannot verify cluster membership in replication group in lws")
