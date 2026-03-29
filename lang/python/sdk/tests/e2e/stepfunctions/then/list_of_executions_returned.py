"""Then: the list of executions is returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the list of executions is returned")
def list_of_executions_returned(world):
    assert world["error"] is None, f"Expected list_executions to succeed but got: {world['error']}"
    assert "executions" in world["result"], "Expected 'executions' in response"
