"""Given: a cluster has been restored from a snapshot"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a cluster has been restored from a snapshot")
def memorydb_cluster_restored_from_snapshot_seq():
    pytest.skip("Cannot trigger internal MemoryDB cluster restore in lws")
