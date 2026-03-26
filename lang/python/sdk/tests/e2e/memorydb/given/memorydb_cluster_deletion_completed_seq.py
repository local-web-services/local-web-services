"""Given: a MemoryDB cluster deletion has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a MemoryDB cluster deletion has completed")
def memorydb_cluster_deletion_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB cluster deletion completion in lws")
