"""When: a MemoryDB cluster update begins"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a MemoryDB cluster update begins")
def memorydb_cluster_update_begins(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB cluster update in lws")
