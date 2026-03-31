"""Given: a "memorydb" "snapshot" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "memorydb" "snapshot" deletion completes')
def memorydb_snapshot_deletion_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB snapshot deletion completion in lws")
