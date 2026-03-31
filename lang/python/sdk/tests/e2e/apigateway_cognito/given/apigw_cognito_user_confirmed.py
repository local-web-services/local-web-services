"""Given: a "cognito" "user" is confirmed in a "cognito" "user pool" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "cognito" "user" is confirmed in a "cognito" "user pool"')
def apigw_cognito_user_confirmed():
    pytest.skip("Cannot configure Cognito authorizer flow for sequence setup in lws")
