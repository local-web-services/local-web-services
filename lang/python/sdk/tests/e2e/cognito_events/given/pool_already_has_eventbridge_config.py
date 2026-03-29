"""Given: the pool already has an EventBridge configuration"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the pool already has an EventBridge configuration")
def pool_already_has_eventbridge_config():
    pytest.skip("Cannot configure EventBridge on a Cognito user pool in lws")
