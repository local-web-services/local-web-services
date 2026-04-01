"""Given: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured'
)
def cognito_lambda_user_initiated_signup_with_trigger():
    pytest.skip("Cannot represent a Cognito signup with trigger as sequence setup in lws")
