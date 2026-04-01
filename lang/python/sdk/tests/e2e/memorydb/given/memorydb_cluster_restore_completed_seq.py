"""Given: a "memorydb" "cluster" restore from "memorydb" "snapshot" completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "memorydb" "cluster" restore from "memorydb" "snapshot" completes')
def memorydb_cluster_restore_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB cluster restore completion in lws")
