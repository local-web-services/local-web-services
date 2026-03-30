"""Given: the "API" has no integration configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "API" has no integration configured')
def apigw_sqs_api_has_no_integration():
    """No-op: APIs have no integration configured by default."""
