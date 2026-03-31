"""Given: the "api gateway" "api" has no "dynamodb" integration configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "api" has no "dynamodb" integration configured')
def apigw_dynamodb_api_has_no_integration():
    """No-op: APIs have no DynamoDB integration configured by default."""
