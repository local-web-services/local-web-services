"""
Given: a cluster modification has begun but event delivery has failed because the bus is deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a cluster modification has begun but event delivery has failed because the bus is deleted")
def docdb_events_cluster_modification_delivery_failed():
    pytest.skip("Cannot trigger internal DocumentDB event delivery failure in lws")
