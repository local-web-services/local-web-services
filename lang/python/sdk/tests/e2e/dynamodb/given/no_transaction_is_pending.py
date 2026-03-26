"""Given: no transaction is "PENDING" """

from __future__ import annotations

from pytest_bdd import given


@given('no transaction is "PENDING"')
def no_transaction_is_pending():
    """No-op: fresh state has no pending transactions."""
