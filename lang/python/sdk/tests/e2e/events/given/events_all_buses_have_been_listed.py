"""Given: all "eventbridge" "bus"es are listed"""

from __future__ import annotations

from pytest_bdd import given


@given('all "eventbridge" "bus"es are listed')
def events_all_buses_have_been_listed():
    """No-op: listing buses requires no precondition."""
