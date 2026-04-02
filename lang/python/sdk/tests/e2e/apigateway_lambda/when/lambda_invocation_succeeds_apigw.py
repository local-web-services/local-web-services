"""When: the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response'
)
def lambda_invocation_succeeds_apigw(world):
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")
