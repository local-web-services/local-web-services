"""
When: the Step Functions execution completes successfully and the "API" returns a successful
response
"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response'
)  # noqa: E501
def sfn_execution_succeeds_apigw(world):
    pytest.skip("Cannot simulate Step Functions execution completion via API Gateway in lws")
