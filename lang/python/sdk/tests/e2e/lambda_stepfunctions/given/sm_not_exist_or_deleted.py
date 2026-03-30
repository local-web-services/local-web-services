"""Given: the state machine does not exist or is "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the state machine does not exist or is "DELETED"')
def sm_not_exist_or_deleted():
    """No-op: fresh state has no state machines."""
