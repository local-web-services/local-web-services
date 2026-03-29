"""Then: the pending subscription is "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the pending subscription is "DELETED"')
def pending_subscription_deleted_then(world):
    pytest.skip("Cannot observe subscription token expiry in integration test context")
