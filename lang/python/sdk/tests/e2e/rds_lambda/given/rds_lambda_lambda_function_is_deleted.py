"""Given: the "lambda" "function" was "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" was "DELETED"')
def rds_lambda_lambda_function_is_deleted():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")
