"""Given: the "cognito" "user pool" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user pool" was not "ACTIVE"')
def apigw_cognito_pool_is_not_active_given():
    pytest.skip("Cannot configure Cognito authorizer on REST API in lws")
