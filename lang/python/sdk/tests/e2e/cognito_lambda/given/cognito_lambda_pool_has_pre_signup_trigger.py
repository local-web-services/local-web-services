"""Given: the "cognito" "user pool" has a pre-signup trigger configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user pool" has a pre-signup trigger configured')
def cognito_lambda_pool_has_pre_signup_trigger():
    pytest.skip("Cannot configure Lambda triggers for Cognito in lws")
