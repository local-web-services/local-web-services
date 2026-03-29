"""Given: the transaction is not "COMMITTED" """

from __future__ import annotations

from pytest_bdd import given


@given('the transaction is not "COMMITTED"')
def transaction_is_not_committed():
    """No-op: default state has no committed transaction."""
