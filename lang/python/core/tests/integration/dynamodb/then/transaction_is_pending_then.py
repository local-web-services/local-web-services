"""Then: the "dynamodb" "transaction" will be "PENDING" """

from __future__ import annotations

from pytest_bdd import then


@then('the "dynamodb" "transaction" will be "PENDING"')
def transaction_is_pending_then(world: dict):
    actual_error = world["error"]
    assert actual_error is None, f"Expected transaction to succeed but got: {actual_error}"
