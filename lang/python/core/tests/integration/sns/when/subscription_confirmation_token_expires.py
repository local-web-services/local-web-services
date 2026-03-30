"""When: a subscription confirmation token expires"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a subscription confirmation token expires")
def subscription_confirmation_token_expires(world):
    pytest.skip("Cannot expire a subscription confirmation token in integration test context")
