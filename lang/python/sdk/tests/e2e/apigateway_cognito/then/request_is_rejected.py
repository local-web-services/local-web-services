"""
Then: the request is "REJECTED" because the token's issuing pool does not match the configured
authorizer
"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the request is "REJECTED" because the token\'s issuing pool does not match '
    "the configured authorizer"
)
def request_is_rejected():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
