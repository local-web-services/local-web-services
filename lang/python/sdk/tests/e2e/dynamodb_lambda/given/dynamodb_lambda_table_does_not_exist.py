"""Given: the table does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the table does not exist")
def dynamodb_lambda_table_does_not_exist():
    """No-op: fresh state has no tables."""
