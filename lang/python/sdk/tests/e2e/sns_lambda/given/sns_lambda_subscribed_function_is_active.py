"""Given: the subscribed "lambda" "function" was "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the subscribed "lambda" "function" was "ACTIVE"')
def sns_lambda_subscribed_function_is_active():
    pytest.skip("Cannot configure SNS subscription to Lambda in lws")
