"""Given: the "api gateway" "api" has no "SNS" integration configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "api" has no "SNS" integration configured')
def apigw_sns_api_has_no_integration():
    """No-op: APIs have no SNS integration configured by default."""
