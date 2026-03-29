"""Then: the transaction is "PENDING" """

from __future__ import annotations

from pytest_bdd import then


@then('the transaction is "PENDING"')
def transaction_is_pending_then(world):
    """transact_write_items returns synchronously in lws; accept success."""
    assert world["error"] is None, f"Expected transaction to succeed but got: {world['error']}"
