"""Given: Cognito has issued a "JWT" token for a confirmed user"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('Cognito has issued a "JWT" token for a confirmed user')
def apigw_cognito_jwt_issued():
    pytest.skip("Cannot configure Cognito authorizer flow for sequence setup in lws")
