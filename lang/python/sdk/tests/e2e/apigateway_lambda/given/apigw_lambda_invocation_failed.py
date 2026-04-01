"""Given: the Lambda invocation fails and the "api gateway" "API" returns an error response"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the Lambda invocation fails and the "api gateway" "API" returns an error response')
@given('the Lambda invocation fails and the "api gateway" "API" returns an error response')
def apigw_lambda_invocation_failed():
    pytest.skip("Cannot represent a failed Lambda invocation as sequence setup in lws")
