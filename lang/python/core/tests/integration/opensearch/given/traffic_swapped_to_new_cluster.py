"""Given: traffic has been swapped to the new "opensearch" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('traffic has been swapped to the new "opensearch" "cluster"')
def traffic_swapped_to_new_cluster(world):
    pytest.skip("Blue-green traffic swap state is not available in stateless integration tests.")
