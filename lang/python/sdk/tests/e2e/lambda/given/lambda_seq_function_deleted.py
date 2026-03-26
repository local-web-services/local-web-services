"""Given: a function has finished being deleted"""

from __future__ import annotations

from pytest_bdd import given


@given("a function has finished being deleted")
def lambda_seq_function_deleted():
    """No-op: fresh state has no functions, simulates a previously deleted function."""
