"""Given: no "dynamodb" "transaction" was "PENDING" """

from __future__ import annotations

from pytest_bdd import given


@given('no "dynamodb" "transaction" was "PENDING"')
def no_transaction_is_pending():
    """No-op: fresh state has no pending transactions."""
