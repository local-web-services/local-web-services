"""Given: the "cognito" "user" already existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user" already existed')
def apigw_cognito_user_already_exists():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
