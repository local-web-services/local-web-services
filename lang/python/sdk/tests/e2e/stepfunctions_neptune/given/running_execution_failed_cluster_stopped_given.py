"""Given: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped'
)
def running_execution_failed_cluster_stopped_given():
    pytest.skip("Cannot pre-set a failed execution Neptune task state for sequence setup")
