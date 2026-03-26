"""Given: the Lambda function has been invoked"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has been invoked")
def lambda_dynamodb_seq_function_invoked():
    pytest.skip("Cannot trigger Lambda invocation in lws")
