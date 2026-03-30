"""Given: the callee is "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the callee is "DELETED"')
def callee_is_deleted_given():
    """No-op: fresh state has no functions (simulates deleted callee)."""
