"""Given: the "dynamodb" "table" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "dynamodb" "table" did not exist')
def table_does_not_exist():
    """No-op: fresh state after reset has no tables."""
