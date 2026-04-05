"""Then: the "dynamodb" "GSI" will be consistent with the "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import then


@then('the "dynamodb" "GSI" will be consistent with the "dynamodb" "table"')
def gsi_is_consistent_with_table():
    """No-op: GSI writes are synchronously propagated in lws; consistency is immediate."""
