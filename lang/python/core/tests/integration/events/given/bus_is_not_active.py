"""Given: the event bus is not "ACTIVE"."""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "eventbridge" "bus" was not "ACTIVE"')
def bus_is_not_active_given():
    pytest.skip("Cannot configure event bus in non-ACTIVE state in integration test context")
