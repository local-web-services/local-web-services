"""Given: the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"')
def rds_lambda_db_configured_with_iam_role():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")
