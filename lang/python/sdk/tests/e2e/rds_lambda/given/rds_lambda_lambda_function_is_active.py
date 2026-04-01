"""Given: the "lambda" "function" was "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" was "ACTIVE"')
def rds_lambda_lambda_function_is_active():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")
