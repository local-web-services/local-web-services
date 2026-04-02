"""When: the "lambda" "function" invocation completes successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "lambda" "function" invocation completes successfully')
def sns_lambda_invocation_completes(world):
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")
