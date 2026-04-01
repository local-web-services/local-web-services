"""Given: the subscription slot is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the subscription slot is not available")
def subscription_slot_not_available():
    pytest.skip("Cannot exhaust subscription slot limit in integration test context")
