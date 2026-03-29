"""Given: a MemoryDB cluster update has begun"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a MemoryDB cluster update has begun")
def memorydb_cluster_update_has_begun_seq():
    pytest.skip("Cannot trigger MemoryDB cluster update in lws")
