"""When: a user is confirmed in a Cognito User Pool"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a user is confirmed in a Cognito User Pool")
def confirm_user_in_pool(world):
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
