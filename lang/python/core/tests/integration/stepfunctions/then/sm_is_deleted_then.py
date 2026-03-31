"""Then: the "step functions" "state machine" was "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "step functions" "state machine" was "DELETED"')
def sm_is_deleted_then(world):
    assert world["error"] is None, f"Expected finalization to succeed but got: {world['error']}"
