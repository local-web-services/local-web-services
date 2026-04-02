"""When: "dynamodb" "write" throttling is toggled on or off"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('"dynamodb" "write" throttling is toggled on or off')
def toggle_write_throttling(world: dict):
    pytest.skip("Cannot toggle write throttling in integration context")
