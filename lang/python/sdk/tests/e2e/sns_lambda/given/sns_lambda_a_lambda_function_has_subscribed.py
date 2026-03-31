"""Given: a "lambda" "function" subscribes to a "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "lambda" "function" subscribes to a "sns" "topic"')
def sns_lambda_a_lambda_function_has_subscribed():
    pytest.skip("Cannot configure SNS subscription to Lambda in lws")
