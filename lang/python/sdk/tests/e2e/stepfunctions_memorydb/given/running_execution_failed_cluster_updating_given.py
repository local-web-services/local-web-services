"""Given: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating'
)
def running_execution_failed_cluster_updating_given():
    pytest.skip("Cannot pre-set a failed execution MemoryDB task state for sequence setup")
