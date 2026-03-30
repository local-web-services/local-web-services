"""Given: an "RDS" stored procedure has invoked the Lambda function and succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "RDS" stored procedure has invoked the Lambda function and succeeded')
def rds_stored_proc_invoked_lambda_succeeded():
    pytest.skip("Cannot trigger RDS->Lambda invocation in lws")
