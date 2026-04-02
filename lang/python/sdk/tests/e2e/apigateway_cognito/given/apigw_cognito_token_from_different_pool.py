"""Given: a "VALID" "cognito" "token" existed from a "cognito" "user" in a different "cognito" "user pool" than the configured authorizer"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a "VALID" "cognito" "token" existed from a "cognito" "user" in a different "cognito" "user pool" than the configured authorizer'
)
def apigw_cognito_token_from_different_pool():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
