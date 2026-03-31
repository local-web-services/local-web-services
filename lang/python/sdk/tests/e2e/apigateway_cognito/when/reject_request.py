"""When: a request with a valid token from a "cognito" "user" in a different pool is rejected"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a request with a valid token from a "cognito" "user" in a different pool is rejected')
def reject_request(world):
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
