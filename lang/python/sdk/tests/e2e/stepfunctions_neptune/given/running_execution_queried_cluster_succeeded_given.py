"""Given: a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded')
def running_execution_queried_cluster_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution Neptune task state for sequence setup")
