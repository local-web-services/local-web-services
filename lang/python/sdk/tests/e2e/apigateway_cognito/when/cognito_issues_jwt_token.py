"""When: Cognito issues a "JWT" token for a confirmed user"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('Cognito issues a "JWT" token for a confirmed user')
def cognito_issues_jwt_token(world):
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
