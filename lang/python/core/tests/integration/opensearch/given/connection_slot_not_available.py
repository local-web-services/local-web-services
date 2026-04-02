"""Given: no "opensearch" "connection" "slot" was "available" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "opensearch" "connection" "slot" was "available"')
def connection_slot_not_available(world):
    pytest.skip("Connection slot limits are not configurable in stateless integration tests.")
