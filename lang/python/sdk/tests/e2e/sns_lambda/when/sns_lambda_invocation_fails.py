"""When: the "lambda" "function" invocation fails"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "lambda" "function" invocation fails')
def sns_lambda_invocation_fails(world):
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")
