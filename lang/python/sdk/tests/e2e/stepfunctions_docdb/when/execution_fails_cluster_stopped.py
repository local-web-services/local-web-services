"""When: a running execution fails to connect because the DocumentDB cluster is stopped"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a running execution fails to connect because the DocumentDB cluster is stopped")
def execution_fails_cluster_stopped(world):
    pytest.skip(
        "Cannot trigger internal execution step that fails due to stopped DocumentDB cluster in lws"
    )
