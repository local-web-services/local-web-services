"""
Given: a user action has occurred but event delivery has failed because the bus has been deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "cognito" "user" action occurs but event delivery fails because the bus has been deleted')
def cognito_events_user_action_delivery_failed():
    pytest.skip("Cannot trigger internal Cognito event delivery failure in lws")
