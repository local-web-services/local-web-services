"""Given: no "sns" "subscription" "slot" was "available" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "sns" "subscription" "slot" was "available"')
def subscription_slot_not_available():
    pytest.skip("Cannot exhaust subscription slot limit in integration test context")
