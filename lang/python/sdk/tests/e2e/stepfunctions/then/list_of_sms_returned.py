"""Then: the list of state machines will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the list of state machines will be returned")
def list_of_sms_returned(world):
    assert (
        world["error"] is None
    ), f"Expected list_state_machines to succeed but got: {world['error']}"
    assert "stateMachines" in world["result"], "Expected 'stateMachines' in response"
