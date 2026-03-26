"""Given: the function has active execution tracking"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the function has active execution tracking")
def function_has_active_execution_tracking(world):
    pytest.skip("Cannot configure execution tracking in integration tests.")
