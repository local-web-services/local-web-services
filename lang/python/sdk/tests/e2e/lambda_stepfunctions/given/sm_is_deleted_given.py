"""Given: the "step functions" "state machine" is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "step functions" "state machine" was "DELETED"')
def sm_is_deleted_given():
    """No-op: fresh state has no state machines (simulates deleted state machine)."""
