"""Given: the "DB" instance does not exist or is not "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "DB" instance does not exist or is not "AVAILABLE"')
def rds_lambda_db_not_exist_or_not_available():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")
