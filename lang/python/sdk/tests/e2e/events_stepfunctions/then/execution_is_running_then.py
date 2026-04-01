"""Then: the "step functions" "execution" will be "RUNNING" """

from __future__ import annotations

from pytest_bdd import then


@then('the "step functions" "execution" will be "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected put_events to succeed but got: {world['error']}"
