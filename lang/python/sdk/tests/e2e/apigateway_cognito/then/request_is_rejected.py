"""
Then: the request is "REJECTED" because the token's issuing pool does not match the configured
authorizer
"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "api gateway" "request" will be "REJECTED" because the "cognito" "token" issuing "cognito" "user pool" does not match the configured authorizer'
)  # noqa: E501
def request_is_rejected():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
