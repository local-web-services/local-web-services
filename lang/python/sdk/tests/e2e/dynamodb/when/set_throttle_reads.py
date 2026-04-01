"""When: throttling is applied to reads"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("throttling is applied to reads")
def set_throttle_reads(world):
    pytest.skip("Cannot apply read throttling in this abstract context")
