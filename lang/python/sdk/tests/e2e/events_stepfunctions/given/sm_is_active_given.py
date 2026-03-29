"""Given: the state machine is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the state machine is "ACTIVE"')
def sm_is_active_given():
    """No-op: state machines are ACTIVE by default."""
