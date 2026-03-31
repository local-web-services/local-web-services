"""Given: a "neptune" "cluster" is restored from a neptune snapshot"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "neptune" "cluster" is restored from a neptune snapshot')
def neptune_cluster_restored_from_snapshot_seq():
    pytest.skip("Cannot trigger internal Neptune cluster restore in lws")
