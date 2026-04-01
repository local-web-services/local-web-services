"""Given: the "cognito" "user" was not "CONFIRMED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user" was not "CONFIRMED"')
def apigw_cognito_user_is_not_confirmed():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
