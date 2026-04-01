"""When: a pending "sns" "subscription" is confirmed"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a pending "sns" "subscription" is confirmed')
def confirm_subscription(world):
    pytest.skip("Cannot confirm subscription without token in integration test context")
