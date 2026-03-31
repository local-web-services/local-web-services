"""When: a "memorydb" "cluster" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "memorydb" "cluster" finishes creating')
def cluster_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB cluster creation completion in lws")
