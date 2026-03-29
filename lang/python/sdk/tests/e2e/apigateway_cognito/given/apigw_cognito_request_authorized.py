"""
Given: a request with a valid token from a user in the "API"'s configured pool has been
authorized
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a request with a valid token from a user in the "API"\'s configured pool has been authorized'
)
def apigw_cognito_request_authorized():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
