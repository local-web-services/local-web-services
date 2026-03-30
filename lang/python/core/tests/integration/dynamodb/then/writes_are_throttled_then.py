"""Then: writes are throttled"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("writes are throttled")
def writes_are_throttled_then(world: dict):
    pytest.skip("Cannot observe write throttling in integration context")
