"""When: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds')
def execution_connects_to_cluster_succeeds(world):
    pytest.skip("Cannot trigger internal execution step that connects to MemoryDB in lws")
