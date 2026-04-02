"""Given: the pre-signup "lambda" "function" denies the signup"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the pre-signup "lambda" "function" denies the signup')
def cognito_lambda_pre_signup_denied():
    pytest.skip("Cannot represent a Lambda trigger invocation result as sequence setup in lws")
