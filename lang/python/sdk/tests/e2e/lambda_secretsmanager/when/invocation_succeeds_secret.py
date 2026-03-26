"""When: the Lambda function reads an "ACTIVE" secret and completes successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Lambda function reads an "ACTIVE" secret and completes successfully')
def invocation_succeeds_secret(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
