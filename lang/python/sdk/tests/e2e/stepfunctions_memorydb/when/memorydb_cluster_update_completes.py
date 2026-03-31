"""When: the "memorydb" "cluster" update completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "memorydb" "cluster" update completes')
def memorydb_cluster_update_completes(world):
    pytest.skip("Cannot trigger internal MemoryDB cluster update completion in lws")
