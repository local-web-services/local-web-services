"""Given: the "api gateway" "API" already has an authorizer configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "api gateway" "API" already has an authorizer configured')
def apigw_cognito_api_already_has_authorizer():
    pytest.skip("Cannot configure Cognito authorizer on REST API in lws")
