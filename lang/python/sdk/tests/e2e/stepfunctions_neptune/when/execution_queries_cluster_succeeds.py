"""When: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds')
def execution_queries_cluster_succeeds(world):
    pytest.skip("Cannot trigger internal execution step that queries Neptune in lws")
