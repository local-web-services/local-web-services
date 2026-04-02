"""Given: the "opensearch" "domain" blue-green traffic had not been swapped yet"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "domain" blue-green traffic had not been swapped yet')
def traffic_not_been_swapped_yet(world):
    world["_skip"] = "Cannot configure blue-green deployment traffic state in lws"
    pytest.skip(world["_skip"])
