"""Given: the Lambda function has failed to call Cognito because the pool has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has failed to call Cognito because the pool has been deleted")
def lambda_cognito_seq_invocation_failed():
    pytest.skip("Cannot trigger Lambda invocation in lws")
