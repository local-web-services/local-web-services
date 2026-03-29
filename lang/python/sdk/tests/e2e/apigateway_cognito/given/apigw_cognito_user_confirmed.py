"""Given: a user has been confirmed in a Cognito User Pool"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a user has been confirmed in a Cognito User Pool")
def apigw_cognito_user_confirmed():
    pytest.skip("Cannot configure Cognito authorizer flow for sequence setup in lws")
