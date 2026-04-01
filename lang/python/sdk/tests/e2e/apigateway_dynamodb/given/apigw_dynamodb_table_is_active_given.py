"""Given: the "dynamodb" "table" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "dynamodb" "table" was "ACTIVE"')
def apigw_dynamodb_table_is_active_given():
    """No-op: DynamoDB tables are ACTIVE immediately after creation."""
