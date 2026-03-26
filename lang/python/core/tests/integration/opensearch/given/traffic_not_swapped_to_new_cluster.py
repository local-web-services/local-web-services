"""Given: traffic has not been swapped to the new cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("traffic has not been swapped to the new cluster")
def traffic_not_swapped_to_new_cluster(world):
    pytest.skip("Blue-green traffic swap state is not available in stateless integration tests.")
