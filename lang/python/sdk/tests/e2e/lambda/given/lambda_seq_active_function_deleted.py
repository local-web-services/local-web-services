"""Given: an active "lambda" "function" is deleted"""

from __future__ import annotations

from pytest_bdd import given


@given('an active "lambda" "function" is deleted')
def lambda_seq_active_function_deleted():
    """No-op: fresh state has no functions, simulates a previously deleted function."""
