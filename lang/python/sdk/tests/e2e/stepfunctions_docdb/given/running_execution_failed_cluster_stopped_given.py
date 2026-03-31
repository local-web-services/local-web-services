"""Given: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped'
)
def running_execution_failed_cluster_stopped_given():
    pytest.skip("Cannot pre-set a failed execution DocumentDB task state for sequence setup")
