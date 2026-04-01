"""Then: reads were throttled"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("reads were throttled")
def reads_are_throttled_then(world: dict):
    pytest.skip("Cannot observe read throttling in integration context")
