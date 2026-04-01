"""Given: the "elasticache" "cluster" is part of a "elasticache" "replication group" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticache" "cluster" is part of a "elasticache" "replication group"')
def cluster_is_part_of_rg(world):
    pytest.skip(
        "lws does not enforce replication group membership when deleting a standalone cluster."
    )
