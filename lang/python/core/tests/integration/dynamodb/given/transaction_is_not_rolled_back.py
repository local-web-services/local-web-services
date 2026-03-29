"""Given: the transaction is not "ROLLED_BACK" """

from __future__ import annotations

from pytest_bdd import given


@given('the transaction is not "ROLLED_BACK"')
def transaction_is_not_rolled_back():
    """No-op: default state has no rolled-back transaction."""
