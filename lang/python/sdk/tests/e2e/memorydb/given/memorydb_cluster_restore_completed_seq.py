"""Given: a cluster restore from snapshot has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a cluster restore from snapshot has completed")
def memorydb_cluster_restore_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB cluster restore completion in lws")
