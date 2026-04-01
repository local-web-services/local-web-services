"""Given: the "cognito" "user pool" already has a trigger configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user pool" already has a trigger configured')
def cognito_lambda_pool_already_has_trigger():
    pytest.skip("Cannot configure Lambda triggers for Cognito in lws")
