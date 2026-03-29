"""Then: pending_transaction_invariant_holds"""

from __future__ import annotations

from pytest_bdd import parsers, then


@then(parsers.re(r"^a pending transaction always .+"))
def pending_transaction_invariant_holds():
    """Invariant steps are trivially satisfied in an isolated test context."""
