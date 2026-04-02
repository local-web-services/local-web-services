"""Given: a "cognito" "user" receives a "VALID" "JWT" token from the "cognito" "user pool" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "cognito" "user" receives a "VALID" "JWT" token from the "cognito" "user pool"')
def apigw_cognito_jwt_issued():
    pytest.skip("Cannot configure Cognito authorizer flow for sequence setup in lws")
