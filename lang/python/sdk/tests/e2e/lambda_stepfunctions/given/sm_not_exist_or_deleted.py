"""Given: the "step functions" "state machine" did not exist or was "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "step functions" "state machine" did not exist or was "DELETED"')
def sm_not_exist_or_deleted():
    """No-op: fresh state has no state machines."""
