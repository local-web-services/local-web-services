"""Given: the "rds" "instance" has a "lambda" "function" integration configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "rds" "instance" has a "lambda" "function" integration configured')
def rds_lambda_db_has_integration():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")
