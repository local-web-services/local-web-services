"""When: a running "step functions" "execution" fails to connect because the cluster is being modified"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a running "step functions" "execution" fails to connect because the cluster is being modified'
)
def execution_fails_cluster_modifying(world):
    pytest.skip(
        "Cannot trigger internal execution step that fails due to "
        "modifying ElastiCache cluster in lws"
    )
