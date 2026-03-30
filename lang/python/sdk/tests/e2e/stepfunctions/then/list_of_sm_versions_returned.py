"""Then: the list of state machine versions is returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the list of state machine versions is returned")
def list_of_sm_versions_returned(world):
    assert (
        world["error"] is None
    ), f"Expected list_state_machine_versions to succeed but got: {world['error']}"
    assert "stateMachineVersions" in world["result"], "Expected 'stateMachineVersions' in response"
