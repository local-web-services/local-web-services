"""When: the Lambda invocation fails and the "api gateway" "API" returns an error response"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Lambda invocation fails and the "api gateway" "API" returns an error response')
def lambda_invocation_fails_apigw(world):
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")
