"""When: the Lambda function fails because the secret is pending deletion"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function fails because the secret is pending deletion")
def invocation_fails_secret_pending(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
