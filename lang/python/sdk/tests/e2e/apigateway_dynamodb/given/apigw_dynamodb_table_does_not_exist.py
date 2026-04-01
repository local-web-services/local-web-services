"""Given: the "dynamodb" "table" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "dynamodb" "table" did not exist')
def apigw_dynamodb_table_does_not_exist():
    """No-op: fresh state has no tables."""
