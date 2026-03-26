"""Given: a running execution has failed to connect because the cluster is being modified"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a running execution has failed to connect because the cluster is being modified")
def running_execution_failed_cluster_modifying_given():
    pytest.skip("Cannot pre-set a failed execution ElastiCache task state for sequence setup")
