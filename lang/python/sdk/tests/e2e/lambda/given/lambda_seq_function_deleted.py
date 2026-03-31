"""Given: a "lambda" "function" finishes being deleted"""

from __future__ import annotations

from pytest_bdd import given


@given('a "lambda" "function" finishes being deleted')
def lambda_seq_function_deleted():
    """No-op: fresh state has no functions, simulates a previously deleted function."""
