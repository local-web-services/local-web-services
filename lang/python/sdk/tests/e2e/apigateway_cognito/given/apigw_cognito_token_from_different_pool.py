"""Given: a "VALID" token exists from a user in a different pool than the configured authorizer"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "VALID" token exists from a user in a different pool than the configured authorizer')
def apigw_cognito_token_from_different_pool():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
