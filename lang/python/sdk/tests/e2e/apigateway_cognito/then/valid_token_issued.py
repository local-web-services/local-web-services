"""Then: a "VALID" token will be issued that can be presented to "API" Gateway for authorization"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('a "VALID" token will be issued that can be presented to "API" Gateway for authorization')
def valid_token_issued():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
