"""When: the pre-signup "lambda" "function" allows the signup"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the pre-signup "lambda" "function" allows the signup')
def pre_signup_lambda_allows(world):
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")
