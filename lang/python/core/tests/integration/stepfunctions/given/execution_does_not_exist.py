"""Given: the "step functions" "execution" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "step functions" "execution" did not exist')
def execution_does_not_exist():
    """No-op: fresh state has no executions."""
