"""Given: the state machine has an EventBridge bus configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the state machine has an EventBridge bus configured")
def sm_has_eventbridge_bus():
    pytest.skip("Cannot pre-configure EventBridge bus on state machine in this context")
