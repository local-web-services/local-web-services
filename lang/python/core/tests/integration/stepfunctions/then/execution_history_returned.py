"""Then: the execution history is returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the execution history is returned")
def execution_history_returned(world):
    assert (
        world["error"] is None
    ), f"Expected get_execution_history to succeed but got: {world['error']}"
    assert "events" in world["result"], "Expected 'events' in response"
