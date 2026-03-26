"""Given: the cluster is part of a replication group"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the cluster is part of a replication group")
def cluster_is_part_of_rg():
    pytest.skip("Cannot create a cluster already in a replication group in lws")
