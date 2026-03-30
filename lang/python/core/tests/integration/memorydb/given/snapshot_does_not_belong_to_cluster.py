"""Given: the snapshot does not belong to this cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the snapshot does not belong to this cluster")
def snapshot_does_not_belong_to_cluster(world):
    pytest.skip("Cannot associate snapshot with a different cluster in integration tests.")
