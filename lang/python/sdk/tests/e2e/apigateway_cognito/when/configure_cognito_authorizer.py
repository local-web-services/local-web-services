"""When: a Cognito User Pool authorizer is configured on the "REST" "API" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a Cognito User Pool authorizer is configured on the "REST" "API"')
def configure_cognito_authorizer(world):
    pytest.skip("Cannot configure Cognito authorizer on REST API in lws")
