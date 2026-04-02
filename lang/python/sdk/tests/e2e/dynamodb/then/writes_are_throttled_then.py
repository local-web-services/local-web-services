"""Then: "dynamodb" "write" throttling was active"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('"dynamodb" "write" throttling was active')
def writes_are_throttled_then(world):
    pytest.skip("Cannot observe throttling in this abstract context")
