"""Given: the state machine is a "STANDARD" type"""

from __future__ import annotations

from pytest_bdd import given


@given('the state machine is a "STANDARD" type')
def sm_is_standard_given():
    """No-op: state machine is STANDARD by default."""
