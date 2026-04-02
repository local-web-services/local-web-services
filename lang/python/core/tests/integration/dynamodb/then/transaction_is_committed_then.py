"""Then: the "dynamodb" "transaction" was "COMMITTED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "dynamodb" "transaction" was "COMMITTED"')
def transaction_is_committed_then(world: dict):
    actual_error = world["error"]
    assert actual_error is None, f"Expected transaction to be committed but got: {actual_error}"
