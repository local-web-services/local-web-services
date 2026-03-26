"""When: a delivery attempt fails"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a delivery attempt fails")
def delivery_fails(world):
    pytest.skip("Cannot trigger delivery failure in integration test context")
