"""Given: a "memorydb" "snapshot" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "memorydb" "snapshot" finishes creating')
def memorydb_snapshot_finished_creating_seq():
    pytest.skip("Cannot trigger internal MemoryDB snapshot creation completion in lws")
