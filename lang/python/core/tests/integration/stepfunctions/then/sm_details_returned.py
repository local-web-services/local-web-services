"""Then: the state machine details are returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the state machine details are returned")
def sm_details_returned(world):
    assert (
        world["error"] is None
    ), f"Expected describe_state_machine to succeed but got: {world['error']}"
    assert "name" in world["result"], "Expected 'name' key in response"
