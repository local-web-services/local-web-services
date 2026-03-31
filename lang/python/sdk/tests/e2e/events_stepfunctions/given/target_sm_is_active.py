"""Given: the target state machine was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the target state machine was "ACTIVE"')
def target_sm_is_active():
    """No-op: state machines are ACTIVE by default after creation."""
