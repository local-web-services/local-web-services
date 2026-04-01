"""Given: the callee "lambda" "function" was "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the callee "lambda" "function" was "DELETED"')
def callee_is_deleted_given():
    """No-op: fresh state has no functions (simulates deleted callee)."""
