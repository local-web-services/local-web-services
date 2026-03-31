"""When: a "cognito" "user" is confirmed in a "cognito" "user pool" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "cognito" "user" is confirmed in a "cognito" "user pool"')
def confirm_user_in_pool(world):
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
