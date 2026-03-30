"""Given: traffic has already been swapped"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("traffic has already been swapped")
def traffic_already_swapped(world):
    pytest.skip("Blue-green traffic swap state is not available in stateless integration tests.")
