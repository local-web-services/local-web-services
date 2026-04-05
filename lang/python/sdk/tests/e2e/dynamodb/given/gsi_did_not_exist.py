"""Given: the "dynamodb" "GSI" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "dynamodb" "GSI" did not exist')
def gsi_did_not_exist():
    """No-op: by default, no GSI item is written, so querying returns nothing."""
