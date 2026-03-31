"""Given: reads were throttled"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("reads were throttled")
def reads_throttled():
    pytest.skip("Read throttling is not configurable in integration context")
