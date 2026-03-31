"""Given: a "memorydb" "cluster" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "memorydb" "cluster" finishes creating')
def memorydb_cluster_has_finished_creating_seq():
    pytest.skip("Cannot trigger internal MemoryDB cluster creation completion in lws")
