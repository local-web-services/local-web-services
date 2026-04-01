"""Given: reads were throttled"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("reads were throttled")
def reads_throttled():
    pytest.skip("Cannot configure read throttling in this abstract context")
