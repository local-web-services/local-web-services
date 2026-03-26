"""Given: traffic has not been swapped yet"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("traffic has not been swapped yet")
def traffic_not_swapped_yet(world):
    pytest.skip("Blue-green traffic swap state is not available in stateless integration tests.")
