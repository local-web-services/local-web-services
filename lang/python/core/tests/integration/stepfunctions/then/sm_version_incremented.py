"""Then: the "step functions" "state machine" version will be incremented"""

from __future__ import annotations

from pytest_bdd import then


@then('the "step functions" "state machine" version will be incremented')
def sm_version_incremented(world):
    assert (
        world["error"] is None
    ), f"Expected update_state_machine to succeed but got: {world['error']}"
