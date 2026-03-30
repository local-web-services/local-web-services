"""Then: the user is "CONFIRMED" and can authenticate"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the user is "CONFIRMED" and can authenticate')
def user_is_confirmed():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
