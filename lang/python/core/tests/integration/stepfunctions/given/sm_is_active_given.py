"""Given: the "step functions" "state machine" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "step functions" "state machine" was "ACTIVE"')
@given('the "step functions" "state machine" will be "ACTIVE"')
def sm_is_active_given():
    """No-op: state machines are ACTIVE immediately after creation."""
