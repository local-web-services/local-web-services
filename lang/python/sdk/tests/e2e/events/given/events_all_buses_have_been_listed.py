"""Given: all event buses are listed"""

from __future__ import annotations

from pytest_bdd import given


@given("all event buses are listed")
def events_all_buses_have_been_listed():
    """No-op: listing buses requires no precondition."""
