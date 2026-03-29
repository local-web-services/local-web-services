"""Given: the "API" has no "SQS" integration configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "API" has no "SQS" integration configured')
def apigw_sqs_api_has_no_sqs_integration():
    """No-op: APIs have no SQS integration configured by default."""
