"""
Given: the Neptune cluster has stopped but event delivery has failed because the bus is deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "neptune" "cluster" stops but event delivery fails because the bus is deleted')
def neptune_cluster_stopped_event_failed_seq():
    pytest.skip("Cannot trigger internal Neptune event delivery failure in lws")
