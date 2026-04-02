"""When: a "cognito" "user" receives a "VALID" "JWT" token from the "cognito" "user pool" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "cognito" "user" receives a "VALID" "JWT" token from the "cognito" "user pool"')
def cognito_issues_jwt_token(world):
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
