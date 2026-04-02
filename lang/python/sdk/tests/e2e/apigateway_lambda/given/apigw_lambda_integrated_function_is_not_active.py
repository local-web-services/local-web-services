"""Given: the integrated "lambda" "function" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the integrated "lambda" "function" was not "ACTIVE"')
def apigw_lambda_integrated_function_is_not_active():
    pytest.skip("Cannot configure Lambda integration on REST API in lws")
