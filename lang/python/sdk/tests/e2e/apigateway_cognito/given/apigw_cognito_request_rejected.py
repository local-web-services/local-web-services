"""Given: a request with a valid token from a "cognito" "user" in a different pool is rejected"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a request with a valid token from a "cognito" "user" in a different pool is rejected')
def apigw_cognito_request_rejected():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
