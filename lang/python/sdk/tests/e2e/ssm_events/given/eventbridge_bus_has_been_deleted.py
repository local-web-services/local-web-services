"""Given: the EventBridge event bus is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the EventBridge event bus is deleted")
def eventbridge_bus_has_been_deleted():
    pytest.skip("Cannot pre-set a deleted event bus state for sequence setup")
