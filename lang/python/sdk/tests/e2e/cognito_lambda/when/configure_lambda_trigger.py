"""When: a Lambda pre-signup trigger is configured on the "cognito" "user pool" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a Lambda pre-signup trigger is configured on the "cognito" "user pool"')
def configure_lambda_trigger(world):
    pytest.skip("Cannot configure Lambda triggers for Cognito in lws")
