"""Given: a snapshot has finished creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a snapshot has finished creating")
def memorydb_snapshot_finished_creating_seq():
    pytest.skip("Cannot trigger internal MemoryDB snapshot creation completion in lws")
