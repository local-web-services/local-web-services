"""When: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds'
)
def execution_reads_from_cluster_succeeds(world):
    pytest.skip("Cannot trigger internal execution step that reads from ElastiCache in lws")
