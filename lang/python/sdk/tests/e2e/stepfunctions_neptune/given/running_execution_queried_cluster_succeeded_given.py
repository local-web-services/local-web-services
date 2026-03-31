"""Given: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds'
)
def running_execution_queried_cluster_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution Neptune task state for sequence setup")
