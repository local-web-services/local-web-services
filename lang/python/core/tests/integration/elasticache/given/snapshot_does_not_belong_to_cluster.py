"""Given: the "elasticache" "snapshot" does not belong to this "elasticache" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticache" "snapshot" does not belong to this "elasticache" "cluster"')
def snapshot_does_not_belong_to_cluster(world):
    pytest.skip("Cannot associate snapshot with a different cluster in integration tests.")
