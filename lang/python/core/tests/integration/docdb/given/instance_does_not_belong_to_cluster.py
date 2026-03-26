"""Given: the instance does not belong to this cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the instance does not belong to this cluster")
def instance_does_not_belong_to_cluster(world):
    pytest.skip("Cannot associate instance with a different cluster in integration tests.")
