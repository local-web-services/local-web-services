"""Given: a Cognito User Pool authorizer has been configured on the "REST" "API" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a Cognito User Pool authorizer has been configured on the "REST" "API"')
def apigw_cognito_authorizer_configured():
    pytest.skip("Cannot configure Cognito authorizer on REST API in lws")
