"""Given: the execution is "RUNNING" """

from __future__ import annotations

from pytest_bdd import given


@given('the execution is "RUNNING"')
def execution_is_running_given():
    """No-op: newly started executions are RUNNING."""
