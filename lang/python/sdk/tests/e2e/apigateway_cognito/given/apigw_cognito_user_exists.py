"""Given: the "cognito" "user" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user" existed')
def apigw_cognito_user_exists():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
