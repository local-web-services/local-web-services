"""Given: EventBridge publishing has been enabled on the user pool"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("EventBridge publishing has been enabled on the user pool")
def cognito_events_publishing_enabled():
    pytest.skip("Cannot configure EventBridge on a Cognito user pool in lws")
