"""Then: the "dynamodb" "transaction" was "COMMITTED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "dynamodb" "transaction" was "COMMITTED"')
def transaction_is_committed_then(world):
    assert world["error"] is None, f"Expected transaction to be committed but got: {world['error']}"
