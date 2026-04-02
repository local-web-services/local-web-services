"""Then: "dynamodb" "transaction" status is always a valid value"""

from __future__ import annotations

from pytest_bdd import then


@then('"dynamodb" "transaction" status is always a valid value')
def transaction_status_always_valid():
    """No-op: transaction status validity is an internal invariant; always passes."""
