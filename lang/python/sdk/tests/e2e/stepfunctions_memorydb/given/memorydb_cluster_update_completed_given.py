"""Given: the "memorydb" "cluster" update completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "cluster" update completes')
def memorydb_cluster_update_completed_given():
    pytest.skip("Cannot pre-set a completed MemoryDB cluster update state for sequence setup")
