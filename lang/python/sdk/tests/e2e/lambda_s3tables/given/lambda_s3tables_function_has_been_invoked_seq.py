"""Given: the Lambda function has been invoked"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has been invoked")
def lambda_s3tables_function_has_been_invoked_seq():
    pytest.skip("Cannot create a completed Lambda invocation in lws")
