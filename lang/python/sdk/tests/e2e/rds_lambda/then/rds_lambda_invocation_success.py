"""Then: the "lambda" "invocation" will be "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "invocation" will be "SUCCESS"')
def rds_lambda_invocation_success():
    pytest.skip("Cannot trigger RDS->Lambda invocation in lws")
