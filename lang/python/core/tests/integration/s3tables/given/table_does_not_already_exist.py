"""Given: the "dynamodb" "table" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "table" did not already exist')
@given('the "dynamodb" "table" did not already exist')
def table_does_not_already_exist():
    """No-op: fresh namespace has no tables."""
