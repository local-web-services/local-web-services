"""Given: a MemoryDB cluster update has begun"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a MemoryDB cluster update has begun")
def memorydb_cluster_update_begun_given():
    pytest.skip("Cannot pre-set a MemoryDB cluster update state for sequence setup")
