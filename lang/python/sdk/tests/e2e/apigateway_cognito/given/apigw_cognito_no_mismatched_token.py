"""Given: no such mismatched "cognito" "token" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no such mismatched "cognito" "token" existed')
def apigw_cognito_no_mismatched_token():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
