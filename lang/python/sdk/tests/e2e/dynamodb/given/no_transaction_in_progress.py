"""Given: no transaction was currently in progress"""

from __future__ import annotations

from pytest_bdd import given


@given("no transaction was currently in progress")
def no_transaction_in_progress():
    """No-op: fresh state has no active transactions."""
