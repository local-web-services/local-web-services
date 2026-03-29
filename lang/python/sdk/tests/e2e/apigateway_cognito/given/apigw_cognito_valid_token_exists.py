"""Given: a "VALID" token exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "VALID" token exists')
def apigw_cognito_valid_token_exists():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
