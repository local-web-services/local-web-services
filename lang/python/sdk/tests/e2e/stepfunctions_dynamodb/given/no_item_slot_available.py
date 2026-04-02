"""Given: no "item" "slot" was "available" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "dynamodb" "item" "slot" was "available"')
@given('no "item" "slot" was "available"')
def no_item_slot_available():
    pytest.skip(
        "lws does not enforce DynamoDB capacity limits for StepFunctions service task"
        " (direct provider call bypasses HTTP capacity check)"
    )
