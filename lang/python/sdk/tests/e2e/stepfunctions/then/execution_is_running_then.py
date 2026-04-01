"""Then: the execution will be "RUNNING" """

from __future__ import annotations

from pytest_bdd import then


@then('the execution will be "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected start_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"
