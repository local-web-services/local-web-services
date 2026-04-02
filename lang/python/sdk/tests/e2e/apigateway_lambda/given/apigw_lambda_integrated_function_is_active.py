"""Given: the integrated "lambda" "function" was "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the integrated "lambda" "function" was "ACTIVE"')
def apigw_lambda_integrated_function_is_active():
    pytest.skip("Cannot configure Lambda integration on REST API in lws")
