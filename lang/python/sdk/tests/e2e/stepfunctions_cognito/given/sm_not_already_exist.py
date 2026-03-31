"""Given: the "step functions" "state machine" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "step functions" "state machine" did not already exist')
def sm_not_already_exist():
    """No-op: fresh state has no state machines."""
