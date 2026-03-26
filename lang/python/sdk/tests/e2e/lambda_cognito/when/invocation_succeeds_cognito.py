"""When: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds')
def invocation_succeeds_cognito(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
