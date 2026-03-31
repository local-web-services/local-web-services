"""Given: the "DB" instance did not exist or was "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "DB" instance did not exist or was "AVAILABLE"')
def rds_lambda_db_not_exist_or_not_available():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")
