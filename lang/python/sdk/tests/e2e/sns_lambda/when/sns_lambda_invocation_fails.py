"""When: the Lambda invocation fails"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda invocation fails")
def sns_lambda_invocation_fails(world):
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")
