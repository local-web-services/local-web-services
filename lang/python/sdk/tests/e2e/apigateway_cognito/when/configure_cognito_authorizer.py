"""When: a "cognito" "user pool" authorizer is configured on the "api gateway" "api" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "cognito" "user pool" authorizer is configured on the "api gateway" "api"')
def configure_cognito_authorizer(world):
    pytest.skip("Cannot configure Cognito authorizer on REST API in lws")
