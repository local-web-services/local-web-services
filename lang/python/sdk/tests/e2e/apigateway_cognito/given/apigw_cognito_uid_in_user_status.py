"""Given: uid in user_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("uid in user_status")
def apigw_cognito_uid_in_user_status():
    pytest.skip("Cannot configure Cognito authorizer flow for sequence setup in lws")
