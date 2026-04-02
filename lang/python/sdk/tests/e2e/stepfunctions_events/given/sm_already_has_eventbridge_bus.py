"""Given: the "step functions" "state machine" already has an "eventbridge" "bus" configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "step functions" "state machine" already has an "eventbridge" "bus" configured')
def sm_already_has_eventbridge_bus():
    pytest.skip("Cannot pre-configure EventBridge bus on state machine in this context")
