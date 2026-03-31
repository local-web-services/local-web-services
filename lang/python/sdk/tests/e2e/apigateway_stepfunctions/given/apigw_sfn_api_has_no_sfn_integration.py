"""Given: the "api gateway" "api" has no Step Functions integration configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "api" has no Step Functions integration configured')
def apigw_sfn_api_has_no_sfn_integration():
    """No-op: APIs have no StepFunctions integration configured by default."""
