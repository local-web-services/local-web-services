"""Given: a "memorydb" "cluster" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "memorydb" "cluster" deletion completes')
def memorydb_cluster_deletion_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB cluster deletion completion in lws")
