"""Given: the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the Lambda function has called a Cognito admin "API" on an "ACTIVE" pool and succeeded')
def lambda_cognito_seq_invocation_succeeded():
    pytest.skip("Cannot trigger Lambda invocation in lws")
