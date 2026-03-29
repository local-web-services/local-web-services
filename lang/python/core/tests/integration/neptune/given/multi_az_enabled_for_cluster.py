"""Given: multi-"AZ" is enabled for the cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('multi-"AZ" is enabled for the cluster')
def multi_az_enabled_for_cluster(world):
    pytest.skip("Multi-AZ state is not configurable in stateless integration tests.")
