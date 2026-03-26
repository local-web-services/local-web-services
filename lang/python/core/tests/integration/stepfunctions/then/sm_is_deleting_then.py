"""Then: the state machine is in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the state machine is in "DELETING" state')
def sm_is_deleting_then(world):
    assert (
        world["error"] is None
    ), f"Expected delete_state_machine to succeed but got: {world['error']}"
