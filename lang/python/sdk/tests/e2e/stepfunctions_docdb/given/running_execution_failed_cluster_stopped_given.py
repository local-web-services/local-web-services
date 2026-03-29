"""Given: a running execution has failed to connect because the DocumentDB cluster is stopped"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a running execution has failed to connect because the DocumentDB cluster is stopped")
def running_execution_failed_cluster_stopped_given():
    pytest.skip("Cannot pre-set a failed execution DocumentDB task state for sequence setup")
