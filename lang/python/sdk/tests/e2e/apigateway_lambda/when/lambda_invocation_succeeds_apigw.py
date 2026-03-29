"""When: the Lambda invocation completes successfully and the "API" returns a successful response"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Lambda invocation completes successfully and the "API" returns a successful response')
def lambda_invocation_succeeds_apigw(world):
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")
