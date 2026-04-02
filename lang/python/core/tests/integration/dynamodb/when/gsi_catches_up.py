"""When: a "dynamodb" "GSI" catches up with pending write propagation"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "dynamodb" "GSI" catches up with pending write propagation')
def gsi_catches_up(world: dict):
    pytest.skip("Cannot trigger GSI propagation externally in integration context")
