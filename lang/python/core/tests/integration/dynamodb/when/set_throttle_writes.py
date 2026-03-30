"""When: throttling is applied to writes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("throttling is applied to writes")
def set_throttle_writes(world: dict):
    pytest.skip("Cannot apply write throttling in integration context")
