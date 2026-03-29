"""Given: no execution is "RUNNING" """

from __future__ import annotations

from pytest_bdd import given


@given('no execution is "RUNNING"')
def no_execution_is_running():
    """No-op: fresh state has no executions."""
