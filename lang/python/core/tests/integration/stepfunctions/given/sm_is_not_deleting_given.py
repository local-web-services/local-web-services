"""Given: the state machine is not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the state machine is not "DELETING"')
def sm_is_not_deleting_given():
    """No-op: state machines are not DELETING by default in a fresh state."""
