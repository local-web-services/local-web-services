"""Given: a snapshot deletion has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a snapshot deletion has completed")
def memorydb_snapshot_deletion_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB snapshot deletion completion in lws")
