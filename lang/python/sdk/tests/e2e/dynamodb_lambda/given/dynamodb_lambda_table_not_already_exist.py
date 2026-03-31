"""Given: the "dynamodb" "table" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "dynamodb" "table" did not already exist')
def dynamodb_lambda_table_not_already_exist():
    """No-op: fresh state has no tables."""
