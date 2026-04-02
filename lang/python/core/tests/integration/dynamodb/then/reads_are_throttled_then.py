"""Then: "dynamodb" "read" throttling was active"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('"dynamodb" "read" throttling was active')
def reads_are_throttled_then(world: dict):
    pytest.skip("Cannot observe read throttling in integration context")
