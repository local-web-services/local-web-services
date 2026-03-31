"""Then: the "api gateway" "API" will validate "JWT" tokens against the configured pool before routing requests"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "api gateway" "API" will validate "JWT" tokens against the configured pool before routing requests'
)
def api_will_validate_jwt():
    pytest.skip("Cannot configure Cognito authorizer on REST API in lws")
