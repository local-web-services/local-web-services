"""Then: the request is "AUTHORIZED" and routed to the backend"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the request is "AUTHORIZED" and routed to the backend')
def request_is_authorized():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
