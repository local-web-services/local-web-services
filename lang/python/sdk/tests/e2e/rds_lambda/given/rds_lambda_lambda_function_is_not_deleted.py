"""Given: the Lambda function is not "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the Lambda function is not "DELETED"')
def rds_lambda_lambda_function_is_not_deleted():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")
