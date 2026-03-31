"""Given: a "RDS" stored procedure invokes the "lambda" "function" and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "RDS" stored procedure invokes the "lambda" "function" and succeeds')
def rds_stored_proc_invoked_lambda_succeeded():
    pytest.skip("Cannot trigger RDS->Lambda invocation in lws")
