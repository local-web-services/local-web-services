"""Given: the Lambda function is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the Lambda function is not "ACTIVE"')
def rds_lambda_lambda_function_is_not_active():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")
