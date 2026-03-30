"""When: the recovery window for a deleted secret expires"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the recovery window for a deleted secret expires")
def recovery_window_expires(world):
    pytest.skip("Cannot expire the recovery window programmatically")
