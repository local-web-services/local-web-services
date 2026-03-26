"""Given: writes are throttled"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("writes are throttled")
def writes_throttled():
    pytest.skip("Cannot configure write throttling in this abstract context")
