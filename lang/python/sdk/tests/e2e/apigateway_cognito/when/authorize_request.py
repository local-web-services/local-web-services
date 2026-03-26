"""When: a request with a valid token from a user in the "API"'s configured pool is authorized"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a request with a valid token from a user in the "API"\'s configured pool is authorized')
def authorize_request(world):
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
