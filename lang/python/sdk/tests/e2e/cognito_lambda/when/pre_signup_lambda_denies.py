"""When: the pre-signup "lambda" "function" denies the signup"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the pre-signup "lambda" "function" denies the signup')
def pre_signup_lambda_denies(world):
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")
