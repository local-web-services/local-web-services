"""Given: the "API" is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "API" is not "ACTIVE"')
def apigw_cognito_api_is_not_active_given():
    pytest.skip("Cannot configure Cognito authorizer on REST API in lws")
