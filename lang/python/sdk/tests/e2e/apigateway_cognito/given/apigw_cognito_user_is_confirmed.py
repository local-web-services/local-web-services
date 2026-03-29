"""Given: the user is "CONFIRMED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the user is "CONFIRMED"')
def apigw_cognito_user_is_confirmed():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
