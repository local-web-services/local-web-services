"""When: an "elasticache" "cluster" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "elasticache" "cluster" deletion completes')
def cache_cluster_deletion_completes(world):
    pytest.skip(
        "lws DescribeCacheClusters with no filter always succeeds "
        "— cannot detect deletion completion."
    )
