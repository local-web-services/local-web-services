"""Given: the target "lambda" "function" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the target "lambda" "function" was not "ACTIVE"')
def events_lambda_target_function_is_not_active():
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")
