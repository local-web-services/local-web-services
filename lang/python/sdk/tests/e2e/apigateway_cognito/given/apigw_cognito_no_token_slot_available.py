"""Given: no "cognito" "token" "slot" was "available" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "cognito" "token" "slot" was "available"')
def apigw_cognito_no_token_slot_available():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
