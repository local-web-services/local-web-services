"""Given: the target state machine is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the target state machine is "ACTIVE"')
def target_sm_is_active():
    """No-op: state machines are ACTIVE by default after creation."""
