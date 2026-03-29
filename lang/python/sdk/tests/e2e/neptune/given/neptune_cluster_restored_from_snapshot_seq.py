"""Given: a cluster has been restored from a snapshot"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a cluster has been restored from a snapshot")
def neptune_cluster_restored_from_snapshot_seq():
    pytest.skip("Cannot trigger internal Neptune cluster restore in lws")
