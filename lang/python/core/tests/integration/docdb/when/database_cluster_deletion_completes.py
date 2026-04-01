"""When: a "documentdb" "cluster" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "documentdb" "cluster" deletion completes')
def database_cluster_deletion_completes(world):
    pytest.skip(
        "lws DescribeDBClusters with no filter always succeeds — cannot detect deletion completion."
    )
