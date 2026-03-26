"""Given: the "API" has a Cognito authorizer configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "API" has a Cognito authorizer configured')
def apigw_cognito_api_has_authorizer():
    pytest.skip("Cannot configure Cognito authorizer on REST API in lws")
