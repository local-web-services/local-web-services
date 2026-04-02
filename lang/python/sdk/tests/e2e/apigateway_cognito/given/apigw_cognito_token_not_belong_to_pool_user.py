"""Given: the "cognito" "token" does not belong to a "CONFIRMED" "cognito" "user" in the configured pool"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'the "cognito" "token" does not belong to a "CONFIRMED" "cognito" "user" in the configured pool'
)
def apigw_cognito_token_not_belong_to_pool_user():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
