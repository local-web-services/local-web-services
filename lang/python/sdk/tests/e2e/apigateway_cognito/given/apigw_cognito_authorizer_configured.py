"""Given: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "cognito" "user pool" authorizer is configured on the "api gateway" "api"')
def apigw_cognito_authorizer_configured():
    pytest.skip("Cannot configure Cognito authorizer on REST API in lws")
