"""Given: the table was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the table was "ACTIVE"')
def sm_is_active_given():
    """No-op: state machines are ACTIVE immediately after creation."""
