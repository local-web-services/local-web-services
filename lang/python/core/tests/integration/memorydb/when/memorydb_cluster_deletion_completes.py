"""When: a MemoryDB cluster deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a MemoryDB cluster deletion completes")
def memorydb_cluster_deletion_completes(world):
    pytest.skip(
        "lws DescribeClusters always succeeds; cluster deletion completion "
        "is not a distinct API call."
    )
