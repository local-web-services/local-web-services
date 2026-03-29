"""
Given: a running execution has connected to the "AVAILABLE" DocumentDB cluster and the task
succeeded
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running execution has connected to the "AVAILABLE" DocumentDB cluster and the task succeeded'
)
def running_execution_connected_cluster_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution DocumentDB task state for sequence setup")
