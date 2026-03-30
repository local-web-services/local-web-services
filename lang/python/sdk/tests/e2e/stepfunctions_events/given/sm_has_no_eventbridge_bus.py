"""Given: the state machine has no EventBridge bus configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the state machine has no EventBridge bus configured")
def sm_has_no_eventbridge_bus():
    pytest.skip("lws does not validate EventBridge bus configuration before starting an execution")
