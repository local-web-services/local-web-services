"""Given: the "dynamodb" "GSI" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "dynamodb" "GSI" did not exist')
def gsi_did_not_exist():
    """No-op: by default, no GSI table is created in the integration context."""
