"""When: a cache cluster deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a cache cluster deletion completes")
def cache_cluster_deletion_completes(world):
    pytest.skip(
        "lws DescribeCacheClusters with no filter always succeeds "
        "— cannot detect deletion completion."
    )
