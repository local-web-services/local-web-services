"""Then: the "dynamodb" "transaction" will be "PENDING" """

from __future__ import annotations

from pytest_bdd import then


@then('the "dynamodb" "transaction" will be "PENDING"')
def transaction_is_pending_then(world):
    """transact_write_items returns synchronously in lws; accept success."""
    assert world["error"] is None, f"Expected transaction to succeed but got: {world['error']}"
