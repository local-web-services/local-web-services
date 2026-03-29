"""Given: the Lambda function is "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the Lambda function is "ACTIVE"')
def rds_lambda_lambda_function_is_active():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")
