"""Given: the "memorydb" "cluster" update completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "cluster" update completes')
def memorydb_cluster_update_has_completed_seq():
    pytest.skip("Cannot trigger MemoryDB cluster update completion in lws")
