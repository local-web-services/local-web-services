"""Given: a "memorydb" "cluster" update completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "memorydb" "cluster" update completes')
def memorydb_cluster_update_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB cluster update completion in lws")
