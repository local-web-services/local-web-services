"""Given: the trigger function is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the trigger function is not "ACTIVE"')
def cognito_lambda_trigger_function_is_not_active():
    pytest.skip("Cannot configure Lambda triggers for Cognito in lws")
