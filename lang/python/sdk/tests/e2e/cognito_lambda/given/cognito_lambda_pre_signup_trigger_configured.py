"""Given: a Lambda pre-signup trigger has been configured on the Cognito User Pool"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a Lambda pre-signup trigger has been configured on the Cognito User Pool")
def cognito_lambda_pre_signup_trigger_configured():
    pytest.skip("Cannot configure Lambda triggers for Cognito in lws")
