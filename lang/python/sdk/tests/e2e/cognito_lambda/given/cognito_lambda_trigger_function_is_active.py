"""Given: the trigger "lambda" "function" was "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the trigger "lambda" "function" was "ACTIVE"')
def cognito_lambda_trigger_function_is_active():
    pytest.skip("Cannot configure Lambda triggers for Cognito in lws")
