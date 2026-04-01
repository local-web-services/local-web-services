"""Given: the "lambda" "function" did not have active execution tracking"""

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" did not have active execution tracking')
def function_does_not_have_active_execution_tracking():
    """No-op: fresh functions have no active execution tracking."""
