"""When: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured'
)
def user_initiates_signup_with_trigger(world):
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")
