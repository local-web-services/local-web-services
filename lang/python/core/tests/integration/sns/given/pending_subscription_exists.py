"""Given: the pending subscription exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the pending subscription exists")
def pending_subscription_exists():
    pytest.skip("Cannot create pending subscription token in integration test context")
