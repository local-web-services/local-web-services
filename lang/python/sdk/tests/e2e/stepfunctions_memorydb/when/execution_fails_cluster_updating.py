"""When: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating'
)
def execution_fails_cluster_updating(world):
    pytest.skip(
        "Cannot trigger internal execution step that fails due to updating MemoryDB cluster in lws"
    )
