"""Given: the user already exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the user already exists")
def apigw_cognito_user_already_exists():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
