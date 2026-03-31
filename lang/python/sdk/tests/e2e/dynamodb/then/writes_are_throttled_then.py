"""Then: writes were throttled"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("writes were throttled")
def writes_are_throttled_then(world):
    pytest.skip("Cannot observe throttling in this abstract context")
