"""Given: traffic has been swapped to the new "opensearch" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('traffic has been swapped to the new "opensearch" "cluster"')
def traffic_has_been_swapped(world):
    world["_skip"] = "Cannot configure blue-green deployment traffic state in lws"
    pytest.skip(world["_skip"])
