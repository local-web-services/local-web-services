"""Given: no "VALID" token existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "VALID" token existed')
def apigw_cognito_no_valid_token():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
