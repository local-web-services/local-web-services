"""Given: the "step functions" "execution" will be "RUNNING" """

from __future__ import annotations

from pytest_bdd import given


@given('the execution was "RUNNING"')
@given('the "step functions" "execution" will be "RUNNING"')
def execution_is_running_given():
    """No-op: newly started executions are RUNNING."""
