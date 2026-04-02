"""Given: the "cognito" "token" belongs to a "CONFIRMED" "cognito" "user" in the "api gateway" "API"'s configured pool"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the token belongs to a "CONFIRMED" user in the "api gateway" "API"\'s configured pool')
def apigw_cognito_token_belongs_to_pool_user():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
