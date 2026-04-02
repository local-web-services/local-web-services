"""When: "dynamodb" "read" throttling is toggled on or off"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('"dynamodb" "read" throttling is toggled on or off')
def toggle_read_throttling(world: dict):
    pytest.skip("Cannot toggle read throttling in integration context")
