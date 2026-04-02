"""Given: the "step functions" "execution" was "RUNNING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "step functions" "execution" was "RUNNING"')
def execution_is_running_given():
    """No-op: newly started executions are RUNNING."""
