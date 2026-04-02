"""Given: the "s3 tables" "table" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "step functions" "state machine" did not exist')
def sm_does_not_exist():
    """No-op: fresh state has no state machines."""
